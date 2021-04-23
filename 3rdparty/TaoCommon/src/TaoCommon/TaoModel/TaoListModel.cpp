#include "TaoListModel.h"

#include <algorithm>
#include <chrono>
#include <QDebug>
TaoListModel::TaoListModel(QObject *parent) : TaoListModelBase(parent)
{
    connect(&mSearchTimer, &QTimer::timeout, this, &TaoListModel::onSearch);
    mSearchTimer.setInterval(300);
    mSearchTimer.setSingleShot(true);
}

TaoListModel::~TaoListModel() { }

void TaoListModel::check(int row, bool checked)
{
    if (row < 0 || row >= mDatas.size()) {
        return;
    }

    mDatas.at(row)->setIsChecked(checked);
    if (mDatas.at(row)->isSelected()) {
        for (const auto &obj : mDatas) {
            if (obj->isVisible() && obj->isSelected()) {
                obj->setIsChecked(checked);
            }
        }
    }

    bool allCheck = true;
    if (checked == false || mDatas.count() <= 0) {
        allCheck = false;
    } else {
        for (const auto &obj : mDatas) {
            if (obj->isVisible() && false == obj->isChecked()) {
                allCheck = false;
                break;
            }
        }
    }
    if (mAllChecked != allCheck) {
        mAllChecked = allCheck;
        emit allCheckedChanged(mAllChecked);
    }
    updateCheckedCount();
}
void TaoListModel::setAllChecked(bool allChecked)
{
    for (const auto &obj : mDatas) {
        if (obj->isVisible()) {
            obj->setIsChecked(allChecked);
        }
    }
    updateCheckedCount();
    if (mAllChecked == allChecked)
        return;

    mAllChecked = allChecked;
    emit allCheckedChanged(mAllChecked);
}
void TaoListModel::search(const QString &searchKey)
{
    mSearchkey = searchKey.simplified();
    mSearchTimer.start(300);
}
void TaoListModel::searchImmediate(const QString &searchKey)
{
    mSearchkey = searchKey.simplified();
    onSearch();
}
void TaoListModel::onSearch()
{

    for (const auto &obj : mDatas)
    {
        obj->setIsVisible(obj->match(mSearchkey));
    }

    updateCalcInfo();
}
void TaoListModel::deselectAll()
{
    for (const auto &obj : mDatas) {
        if (obj->isVisible()) {
            obj->setIsSelected(false);
        }
    }
    updateSelectedCount();
}

void TaoListModel::selectAll()
{
    for (const auto &obj : mDatas) {
        if (obj->isVisible()) {
            obj->setIsSelected(true);
        }
    }
    updateSelectedCount();
}

bool TaoListModel::isSelected(int row) const
{
    if (row < 0 || row >= mDatas.size()) {
        return false;
    }
    return mDatas.at(row)->isSelected();
}

void TaoListModel::select(int row)
{
    if (row < 0 || row >= mDatas.size()) {
        return;
    }
    mDatas.at(row)->setIsSelected(true);
    updateSelectedCount();
}

void TaoListModel::deselect(int row)
{
    if (row < 0 || row >= mDatas.size()) {
        return;
    }
    mDatas.at(row)->setIsSelected(false);
    updateSelectedCount();
}

void TaoListModel::selectRange(int from, int to)
{
    int minRow = qMin(from, to);
    int maxRow = qMax(from, to);
    for (int i = 0; i < mDatas.size(); ++i) {
        mDatas.at(i)->setIsSelected(mDatas.at(i)->isVisible() && minRow <= i && i <= maxRow);
    }
    updateSelectedCount();
}

void TaoListModel::selectSingle(int row)
{
    for (int i = 0; i < mDatas.size(); ++i) {
        mDatas.at(i)->setIsSelected(i == row);
    }
    updateSelectedCount();
}
void TaoListModel::doPress(int row, bool shift, bool ctrl, bool outRange)
{
    if (outRange) {
        row = mDatas.size();
    } else {
        if (row < 0 || row >= mDatas.size()) {
            return;
        }
    }

    mIsPressed = true;
    if (ctrl) {
        mLastPressedRow = row;
        if (isSelected(mLastPressedRow)) {
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
void TaoListModel::doMove(int row, bool outRange)
{
    if (outRange) {
        row = mDatas.size();
    } else {

        if (row < 0 || row >= mDatas.size()) {
            return;
        }
    }
    if (mIsPressed) {
        selectRange(mLastPressedRow, row);
    }
}
void TaoListModel::doRelease()
{
    mIsPressed = false;
}

void TaoListModel::sortByRole()
{
    if (mDatas.size() <= 1)
    {
        return;
    }
    if (mSortOrder == Qt::SortOrder::AscendingOrder) 
    {
        if (const auto &sortCall = mSortCallbacksAscend.value(mSortRole)) 
        {
            QList<TaoListItemBase *> copyObjs;
            copyObjs = mDatas;
            std::sort(copyObjs.begin(), copyObjs.end(), sortCall);
            mDatas = copyObjs;
            emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
            updateAlternate();
        }
    }
    else
    {
        if (const auto &sortCall = mSortCallbacksDescend.value(mSortRole))
        {
            QList<TaoListItemBase *> copyObjs;
            copyObjs = mDatas;
            std::sort(copyObjs.begin(), copyObjs.end(), sortCall);
            mDatas = copyObjs;
            emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
            updateAlternate();
        }
    }
}

void TaoListModel::setHeaderRoles(const QStringList &headerRoles)
{
    if (mHeaderRoles == headerRoles)
        return;

    mHeaderRoles = headerRoles;
    emit headerRolesChanged(mHeaderRoles);
}

void TaoListModel::setSortOrder(Qt::SortOrder sortOrder)
{
    if (mSortOrder == sortOrder)
        return;

    mSortOrder = sortOrder;
    emit sortOrderChanged(mSortOrder);
}

void TaoListModel::setSortRole(const QString &sortRole)
{
    if (mSortRole == sortRole)
        return;

    mSortRole = sortRole;
    emit sortRoleChanged(mSortRole);
}

void TaoListModel::updateAllCheck()
{
    bool allCheck = false;
    if (!mDatas.empty()) {
        allCheck = std::all_of(mDatas.begin(), mDatas.end(), [](TaoListItemBase *obj) {
            return obj->isVisible() && obj->isChecked();
        });
    }
    if (mAllChecked == allCheck)
        return;

    mAllChecked = allCheck;
    emit allCheckedChanged(mAllChecked);
}

void TaoListModel::updateVisibleCount()
{
    int count = std::count_if(mDatas.begin(), mDatas.end(),
                              [](TaoListItemBase *obj) { return obj->isVisible(); });
    setVisibledCount(count);
}

void TaoListModel::updateSelectedCount()
{
    int count = std::count_if(mDatas.begin(), mDatas.end(), [](TaoListItemBase *obj) {
        return obj->isVisible() && obj->isSelected();
    });
    setSelectedCount(count);
}

void TaoListModel::updateCheckedCount()
{
    int count = std::count_if(mDatas.begin(), mDatas.end(), [](TaoListItemBase *obj) {
        return obj->isVisible() && obj->isChecked();
    });
    setCheckedCount(count);
}
void TaoListModel::updateAlternate()
{
    bool alter = false;
    for (const auto &obj : mDatas) {
        if (obj->isVisible()) {
            obj->setIsAlternate(alter);
            alter = !alter;
        }
    }
}
void TaoListModel::setVisibledCount(int visibledCount)
{
    if (mVisibledCount == visibledCount)
        return;

    mVisibledCount = visibledCount;
    emit visibledCountChanged(mVisibledCount);
}

void TaoListModel::setSelectedCount(int selectedCount)
{
    if (mSelectedCount == selectedCount)
        return;

    mSelectedCount = selectedCount;
    emit selectedCountChanged(mSelectedCount);
}

void TaoListModel::setCheckedCount(int checkedCount)
{
    if (mCheckedCount == checkedCount)
        return;

    mCheckedCount = checkedCount;
    emit checkedCountChanged(mCheckedCount);
}

void TaoListModel::updateCalcInfo()
{
    updateAllCheck();
    updateCheckedCount();
    updateVisibleCount();
    updateSelectedCount();
    updateAlternate();
    emit signalUpdateCalcCount();
}
