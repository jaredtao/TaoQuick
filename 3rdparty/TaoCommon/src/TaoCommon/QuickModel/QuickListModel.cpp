#include "QuickModel/QuickListModel.h"

#include <QDebug>
#include <algorithm>
QuickListModel::QuickListModel(QObject *parent)
    : QuickModelBase(parent)
{
    connect(&mSearchTimer, &QTimer::timeout, this, &QuickListModel::onSearch);
    mSearchTimer.setInterval(300);
    mSearchTimer.setSingleShot(true);
}

QuickListModel::~QuickListModel()
{
}

void QuickListModel::check(int row, bool checked)
{
    if (row < 0 || row >= mDatas.size())
    {
        return;
    }

    mDatas.at(row)->setIsChecked(checked);
    if (mDatas.at(row)->isSelected())
    {
        for (const auto &obj : mDatas)
        {
            if (obj->isVisible() && obj->isSelected())
            {
                obj->setIsChecked(checked);
            }
        }
    }

    bool allCheck = true;
    if (checked == false || mDatas.count() <= 0)
    {
        allCheck = false;
    }
    else
    {
        for (const auto &obj : mDatas)
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
    for (const auto &obj : mDatas)
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
    //mSearchTimer.start(400);
    onSearch();
}
void QuickListModel::searchImmediate(const QString &searchKey)
{
    mSearchkey = searchKey.simplified();
    onSearch();
}
void QuickListModel::onSearch()
{
    emit beginSearch();

    QList<QuickListItemBase *> newDatas;

    int  vcount = 0;
    for (const auto &obj : mAllDatas)
	{
		bool v = mVisibleCallback == NULL || mVisibleCallback(obj);
		bool m = obj->match(mSearchkey);

		if (v && m)
		{
			newDatas.push_back(obj);
			vcount++;
		}
	}

	if (!compareDataChanged(mDatas, newDatas))
	{
        sortByRole();
		emit endSearch();
		return;
	}

	mDatas = newDatas;
	sortByRole();
    //qWarning() << mSearchkey << vcount;
    //emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0), QVector<int>{Qt::EditRole, Qt::DisplayRole});
    beginResetModel();
    endResetModel();
    updateCalcInfo();
	emit endSearch();
}
void QuickListModel::deselectAll()
{
    for (const auto &obj : mDatas)
    {
        if (obj->isVisible())
        {
            obj->setIsSelected(false);
        }
    }
    updateSelectedCount();
    emit selectedAction();
}

void QuickListModel::selectAll()
{
    for (const auto &obj : mDatas)
    {
        if (obj->isVisible())
        {
            obj->setIsSelected(true);
        }
    }
    updateSelectedCount();
    emit selectedAction();
}

bool QuickListModel::isSelected(int row) const
{
    if (row < 0 || row >= mDatas.size())
    {
        return false;
    }
    return mDatas.at(row)->isSelected();
}

void QuickListModel::select(int row)
{
    if (row < 0 || row >= mDatas.size())
    {
        return;
    }
    mDatas.at(row)->setIsSelected(true);
    updateSelectedCount();
    emit selectedAction();
}

void QuickListModel::deselect(int row)
{
    if (row < 0 || row >= mDatas.size())
    {
        return;
    }
    mDatas.at(row)->setIsSelected(false);
    updateSelectedCount();
    emit selectedAction();
}

void QuickListModel::selectRange(int from, int to)
{
    int minRow = qMin(from, to);
    int maxRow = qMax(from, to);
    for (int i = 0; i < mDatas.size(); ++i)
    {
        mDatas.at(i)->setIsSelected(mDatas.at(i)->isVisible() && minRow <= i && i <= maxRow);
    }
    updateSelectedCount();
    emit selectedAction();
}

void QuickListModel::selectSingle(int row)
{
    for (int i = 0; i < mDatas.size(); ++i)
    {
        mDatas.at(i)->setIsSelected(i == row);
    }
    updateSelectedCount();
    emit selectedAction();
}
void QuickListModel::doPress(int row, bool shift, bool ctrl, bool outRange)
{
    if (outRange)
    {
        row = mDatas.size();
    }
    else
    {
        if (row < 0 || row >= mDatas.size())
        {
            return;
        }
    }

    mIsPressed = true;
    if (ctrl)
    {
        mLastPressedRow = row;
        if (isSelected(mLastPressedRow))
        {
            deselect(mLastPressedRow);
        }
        else
        {
            select(mLastPressedRow);
        }
    }
    else if (shift)
    {
        selectRange(mLastPressedRow, row);
    }
    else
    {
        mLastPressedRow = row;
        selectSingle(mLastPressedRow);
    }
}
void QuickListModel::doMove(int row, bool outRange)
{
    if (outRange)
    {
        row = mDatas.size();
    }
    else
    {

        if (row < 0 || row >= mDatas.size())
        {
            return;
        }
    }
    if (mIsPressed)
    {
        selectRange(mLastPressedRow, row);
    }
}
void QuickListModel::doRelease()
{
    mIsPressed = false;
}

void QuickListModel::sortByRole()
{
    if (mDatas.size() <= 1)
    {
        return;
    }
    if (mSortOrder == Qt::SortOrder::AscendingOrder) 
    {
        if (const auto &sortCall = mSortCallbacksAscend.value(mSortRole)) 
        {
            QList<QuickListItemBase *> copyObjs;
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
            QList<QuickListItemBase *> copyObjs;
            copyObjs = mDatas;
            std::sort(copyObjs.begin(), copyObjs.end(), sortCall);
            mDatas = copyObjs;
            emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
            updateAlternate();
        }
    }
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
    bool allCheck = false;
    if (!mDatas.empty())
    {
        allCheck = std::all_of(mDatas.begin(), mDatas.end(), [](QuickListItemBase *obj) { return obj->isVisible() && obj->isChecked(); });
    }
    if (mAllChecked == allCheck)
        return;

    mAllChecked = allCheck;
    emit allCheckedChanged(mAllChecked);
}

void QuickListModel::updateVisibleCount()
{
    int count = mDatas.count();// std::count_if(mDatas.begin(), mDatas.end(), [](QuickListItemBase *obj) { return obj->isVisible(); });
    setVisibledCount(count);
}

void QuickListModel::updateSelectedCount()
{
    int count = std::count_if(mDatas.begin(), mDatas.end(), [](QuickListItemBase *obj) { return obj->isVisible() && obj->isSelected(); });
    setSelectedCount(count);
}

void QuickListModel::updateCheckedCount()
{
    int count = std::count_if(mDatas.begin(), mDatas.end(), [](QuickListItemBase *obj) { return obj->isVisible() && obj->isChecked(); });
    setCheckedCount(count);
}
void QuickListModel::updateAlternate()
{
    bool alter = false;
    for (const auto &obj : mDatas)
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
