#include "QuickListModel.h"
#include "QuickItemBase.h"
#include <algorithm>
QuickListModel::QuickListModel(QObject *parent)
    : QuickListModelBase(parent)
{
}

QuickListModel::~QuickListModel()
{
}

void QuickListModel::check(int row, bool checked)
{
    if (row < 0 || row >= mObjs.size())
    {
        return;
    }

    mObjs.at(row)->setIsChecked(checked);
    if (mObjs.at(row)->isSelected())
    {
        for (const auto &obj : mObjs)
        {
            if (obj->isVisible() && obj->isSelected())
            {
                obj->setIsChecked(checked);
            }
        }
    }

    bool allCheck = true;
    if (checked == false || mObjs.count() <= 0)
    {
        allCheck = false;
    }
    else
    {
        for (const auto &obj : mObjs)
        {
            if (obj->isVisible() && false == obj->isChecked())
            {
                allCheck = false;
                break;
            }
        }
    }
    if (mAllChecked != allCheck)
    {
        mAllChecked = allCheck;
        emit allCheckedChanged(mAllChecked);
    }
    updateCheckedCount();
}
void QuickListModel::setAllChecked(bool allChecked)
{
    for (const auto &obj : mObjs)
    {
        if (obj->isVisible())
        {
            obj->setIsChecked(allChecked);
        }
    }
    updateCheckedCount();
    if (mAllChecked == allChecked)
        return;

    mAllChecked = allChecked;
    emit allCheckedChanged(mAllChecked);
}
void QuickListModel::search(const QString &searchKey)
{
    mSearchkey = searchKey.simplified();
    for (const auto &obj : mObjs)
    {
        if (mVisibleCallback && false == mVisibleCallback(obj))
        {
            obj->setIsVisible(false);
            continue;
        }
        bool found = false;
        for (const auto &role : mHeaderRoles)
        {
            if (obj->property(role.toStdString().c_str()).toString().contains(mSearchkey))
            {
                found = true;
                break;
            }
        }
        obj->setIsVisible(found);
    }
    updateCalcInfo();
}

void QuickListModel::deselectAll()
{
    for (const auto &obj : mObjs)
    {
        if (obj->isVisible())
        {
            obj->setIsSelected(false);
        }
    }
    updateSelectedCount();
}

void QuickListModel::selectAll()
{
    for (const auto &obj : mObjs)
    {
        if (obj->isVisible())
        {
            obj->setIsSelected(true);
        }
    }
    updateSelectedCount();
}

bool QuickListModel::isSelected(int row) const
{
    if (row < 0 || row >= mObjs.size())
    {
        return false;
    }
    return mObjs.at(row)->isSelected();
}

void QuickListModel::select(int row)
{
    if (row < 0 || row >= mObjs.size())
    {
        return;
    }
    mObjs.at(row)->setIsSelected(true);
    updateSelectedCount();
}

void QuickListModel::deselect(int row)
{
    if (row < 0 || row >= mObjs.size())
    {
        return;
    }
    mObjs.at(row)->setIsSelected(false);
    updateSelectedCount();
}

void QuickListModel::selectRange(int from, int to)
{
    int minRow = qMin(from, to);
    int maxRow = qMax(from, to);
    for (int i = 0; i < mObjs.size(); ++i)
    {
        mObjs.at(i)->setIsSelected(mObjs.at(i)->isVisible() && minRow <= i && i <= maxRow);
    }
    updateSelectedCount();
}

void QuickListModel::selectSingle(int row)
{
    for (int i = 0; i < mObjs.size(); ++i)
    {
        mObjs.at(i)->setIsSelected(i == row);
    }
    updateSelectedCount();
}
void QuickListModel::doPress(int row, bool shift, bool ctrl, bool outRange)
{
    if (outRange) 
    {
        row = mObjs.size();
    }
    else
    {
        if (row < 0 || row >= mObjs.size())
        {
            return;
        }
    }

    mIsPressed = true;
    if (ctrl) {
        mLastPressedRow = row;
        if(isSelected(mLastPressedRow)) {
            deselect(mLastPressedRow);
        } else {
            select(mLastPressedRow);
        }
    } else if (shift) {
        selectRange(mLastPressedRow, row);
    } else {
        mLastPressedRow = row;
        selectSingle(mLastPressedRow);
    }
}
void QuickListModel::doMove(int row, bool outRange)
{
    if (outRange)
    {
        row = mObjs.size();
    }
    else
    {

        if (row < 0 || row >= mObjs.size())
        {
            return;
        }
    }
    if (mIsPressed) {
        selectRange(mLastPressedRow, row);
    }
}
void QuickListModel::doRelease()
{
    mIsPressed = false;
}

void QuickListModel::sortByRole()
{
    const static auto addRessStr = QStringLiteral("address");
    if (mObjs.isEmpty())
    {
        return;
    }

    const auto &addressCallback = mSortCallbacks.value(addRessStr);

    QList<QuickItemBase *> copyObjs;
    if (mSortRole == addRessStr)
    {
        if (addressCallback)
        {
            copyObjs = mObjs;
            if (mSortOrder == Qt::SortOrder::AscendingOrder)
            {
                std::sort(copyObjs.begin(), copyObjs.end(), addressCallback);
            }
            else
            {
                std::sort(copyObjs.begin(), copyObjs.end(), [=](QuickItemBase *obj1, QuickItemBase *obj2) -> bool { return addressCallback(obj2, obj1); });
            }
            beginResetModel();
            mObjs = copyObjs;
            endResetModel();
        }
    }
    else
    {
        if (addressCallback)
        {
            copyObjs = mObjs;
            if (mSortOrder == Qt::SortOrder::AscendingOrder)
            {
                std::sort(copyObjs.begin(), copyObjs.end(), addressCallback);
            }
            else
            {
                std::sort(copyObjs.begin(), copyObjs.end(), [=](QuickItemBase *obj1, QuickItemBase *obj2) -> bool { return addressCallback(obj2, obj1); });
            }
        }
        if (mSortCallbacks.value(mSortRole))
        {
            if (copyObjs.isEmpty())
            {
                copyObjs = mObjs;
            }
            if (mSortOrder == Qt::SortOrder::AscendingOrder)
            {
                std::sort(copyObjs.begin(), copyObjs.end(), mSortCallbacks.value(mSortRole));
            }
            else
            {
                std::sort(copyObjs.begin(), copyObjs.end(), [=](QuickItemBase *obj1, QuickItemBase *obj2) -> bool {
                    return mSortCallbacks.value(mSortRole)(obj2, obj1);
                });
            }
            beginResetModel();
            mObjs = copyObjs;
            endResetModel();
        }
    }
    updateAlternate();
}

void QuickListModel::setHeaderRoles(const QStringList &headerRoles)
{
    if (mHeaderRoles == headerRoles)
        return;

    mHeaderRoles = headerRoles;
    emit headerRolesChanged(mHeaderRoles);
}

void QuickListModel::setSortOrder(Qt::SortOrder sortOrder)
{
    if (mSortOrder == sortOrder)
        return;

    mSortOrder = sortOrder;
    emit sortOrderChanged(mSortOrder);
}

void QuickListModel::setSortRole(const QString &sortRole)
{
    if (mSortRole == sortRole)
        return;

    mSortRole = sortRole;
    emit sortRoleChanged(mSortRole);
}

void QuickListModel::updateAllCheck()
{
    bool allCheck = true;
    if (!mObjs.empty()) {
        allCheck = std::all_of(mObjs.begin(), mObjs.end(), [](QuickItemBase *obj){
            return obj->isVisible() && obj->isChecked();
        });
    }
    if (mAllChecked == allCheck)
        return;

    mAllChecked = allCheck;
    emit allCheckedChanged(mAllChecked);
}

void QuickListModel::updateVisibleCount()
{
    int count = std::count_if(mObjs.begin(), mObjs.end(), [](QuickItemBase *obj){
        return obj->isVisible();
    });
    setVisibledCount(count);
}

void QuickListModel::updateSelectedCount()
{
    int count = std::count_if(mObjs.begin(), mObjs.end(), [](QuickItemBase *obj){
        return obj->isVisible() && obj->isSelected();
    });
    setSelectedCount(count);
}

void QuickListModel::updateCheckedCount()
{
    int count = std::count_if(mObjs.begin(), mObjs.end(), [](QuickItemBase *obj){
        return obj->isVisible() && obj->isChecked();
    });
    setCheckedCount(count);
}
void QuickListModel::updateAlternate()
{
    bool alter = false;
    for (const auto &obj : mObjs)
    {
        if (obj->isVisible())
        {
            obj->setIsAlternate(alter);
            alter = !alter;
        }
    }
}
void QuickListModel::setVisibledCount(int visibledCount)
{
    if (mVisibledCount == visibledCount)
        return;

    mVisibledCount = visibledCount;
    emit visibledCountChanged(mVisibledCount);
}

void QuickListModel::setSelectedCount(int selectedCount)
{
    if (mSelectedCount == selectedCount)
        return;

    mSelectedCount = selectedCount;
    emit selectedCountChanged(mSelectedCount);
}

void QuickListModel::setCheckedCount(int checkedCount)
{
    if (mCheckedCount == checkedCount)
        return;

    mCheckedCount = checkedCount;
    emit checkedCountChanged(mCheckedCount);
}

void QuickListModel::updateCalcInfo()
{
    updateAllCheck();
    updateCheckedCount();
    updateVisibleCount();
    updateSelectedCount();
    updateAlternate();
    emit signalUpdateCalcCount();
}
