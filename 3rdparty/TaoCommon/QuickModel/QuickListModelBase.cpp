#include "QuickListModelBase.h"
#include "QuickItemBase.h"
QuickListModelBase::QuickListModelBase(QObject *parent)
    : QAbstractListModel(parent)
{
}

QuickListModelBase::~QuickListModelBase() {}

int QuickListModelBase::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return mObjs.count();
}

QVariant QuickListModelBase::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= mObjs.size()) {
        return {};
    }

    if (role == Qt::DisplayRole || role == Qt::EditRole) {
        auto obj = mObjs.at(index.row());
        return QVariant::fromValue(obj);
    }

    return {};
}
QVariant QuickListModelBase::data(int row, int role) const
{
    if (row < 0 || row >= mObjs.size())
    {
        return {};
    }

    if (role == Qt::DisplayRole || role == Qt::EditRole)
    {
        auto obj = mObjs.at(row);
        return QVariant::fromValue(obj);
    }

    return {};
}
void QuickListModelBase::resetData(const QList<QuickItemBase *> &objs)
{
    auto oldObjs = mObjs;
    beginResetModel();
    mObjs = objs;
    endResetModel();
    qDeleteAll(oldObjs);
    updateCalcInfo();
}

void QuickListModelBase::append(const QList<QuickItemBase *> &objs)
{
    beginInsertRows({}, mObjs.count(), mObjs.count());
    mObjs.append(objs);
    endInsertRows();
    updateCalcInfo();
}

void QuickListModelBase::prepend(QuickItemBase *obj)
{
    beginInsertRows({}, 0, 0);
    mObjs.prepend(obj);
    endInsertRows();
    updateCalcInfo();
}

void QuickListModelBase::insert(int row, const QList<QuickItemBase *> &objs)
{
    if (row < 0 || row >= mObjs.size()) {
        return;
    }
    beginInsertRows({}, row, row);
    int srow = row;
    for (const auto &obj : objs) {
        mObjs.insert(srow, obj);
        srow++;
    }
    endInsertRows();
    updateCalcInfo();
}

void QuickListModelBase::clear()
{
    beginRemoveRows({}, 0, mObjs.count());
    qDeleteAll(mObjs);
    mObjs.clear();
    endRemoveRows();
    updateCalcInfo();
}

void QuickListModelBase::removeAt(int row)
{
    if (row < 0 || row >= mObjs.size()) {
        return;
    }
    beginRemoveRows({}, row, row);
    auto obj = mObjs.at(row);
    mObjs.removeAt(row);
    endRemoveRows();
    obj->deleteLater();
    updateCalcInfo();
}

void QuickListModelBase::updateData(int row, QuickItemBase *obj)
{
    if (row < 0 || row >= mObjs.size()) {
        return;
    }
    auto oldObj = mObjs.at(row);
    mObjs[row] = obj;
    emit dataChanged(index(row, 0), index(row, 0));
    oldObj->deleteLater();
    updateCalcInfo();
}
