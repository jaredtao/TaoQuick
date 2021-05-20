#pragma once
#include <QAbstractListModel>
#include <QList>
#include "TaoCommonGlobal.h"
template <class T>
class QuickModelBase : public QAbstractListModel
{
public:
    using Super = QAbstractListModel;
    explicit QuickModelBase(QObject *parent = nullptr);
    explicit QuickModelBase(const QList<T> &datas, QObject *parent = nullptr);
    virtual ~QuickModelBase() override;

public:
    //[begin] query data
    int      rowCount(const QModelIndex &parent) const override;
    QVariant data(int row) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    //[end] query data

    //[begin] reset data
    void            resetData(const QList<T> &datas);
    const QList<T> &datas() const
    {
        return mDatas;
    }
	const QSet<T> &allDatas() const
	{
		return mAllDatas;
	}

    //[begin] add data
    void append(const QList<T> &datas);
    void prepend(T data);
    void insert(int row, const QList<T> &datas);
    //[end] add data

    //[begin] remove data
    void clear();
    void removeAt(int row);
	void subtract(const QSet<T> &other);
    //[end] remove data

    //[begin] update data
    void updateData(int row, T data);
    //[end] update data

public:
    virtual void updateCalcInfo()
    {
    }
	bool compareDataChanged(const  QList<T>& data1, const  QList<T>& data2)
	{
		bool changed = false;

		QSet<T>		set1;
		for (auto it = data1.begin(); it != data1.end(); it++)	set1.insert(*it);

		QSet<T>		set2;
		for (auto it = data2.begin(); it != data2.end() && !changed; it++)
		{
			if (set1.find(*it) == set1.end())
			{
				changed = true;
				break;
			}
			set2.insert(*it);
		}

		for (auto it = set1.begin(); it != set1.end() && !changed; it++)
		{
			if (set2.find(*it) == set2.end())
			{
				changed = true;
				break;
			}
		}

		return changed;
	}
protected:
    QList<T> mDatas;
	QSet<T>	 mAllDatas;
};


template <class T>
QuickModelBase<T>::QuickModelBase(QObject *parent)
    : Super(parent)
{
}
template <class T>
QuickModelBase<T>::QuickModelBase(const QList<T> &datas, QObject *parent)
    : Super(parent)
    , mDatas(datas)
{
	for (auto it = datas.begin(); it != datas.end(); it++) mAllDatas.insert(*it);
}
template <class T>
QuickModelBase<T>::~QuickModelBase()
{
    mDatas.clear();
	mAllDatas.clear();
}

template <class T>
int QuickModelBase<T>::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return mDatas.count();
}
template <class T>
QVariant QuickModelBase<T>::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= mDatas.size())
    {
        return {};
    }

    if (role == Qt::DisplayRole || role == Qt::EditRole)
    {
        auto data = mDatas.at(index.row());
        return QVariant::fromValue(data);
    }

    return {};
}
template <class T>
QVariant QuickModelBase<T>::data(int row) const
{
    return data(index(row), Qt::DisplayRole);
}
template <class T>
void QuickModelBase<T>::resetData(const QList<T> &datas)
{
	auto oldObjs = mAllDatas;
	mAllDatas.clear();
    beginResetModel();
    mDatas = datas;
	for (auto it = datas.begin(); it != datas.end(); it++) mAllDatas.insert(*it);
    endResetModel();
    qDeleteAll(oldObjs);
    updateCalcInfo();
}

template <class T>
void QuickModelBase<T>::append(const QList<T> &datas)
{
    if (datas.count() <= 0)
    {
        return;
    }
    beginInsertRows({}, mDatas.count(), mDatas.count() + datas.count() - 1);
    mDatas.append(datas);
	for (auto it = datas.begin(); it != datas.end(); it++) mAllDatas.insert(*it);
    endInsertRows();
    updateCalcInfo();
}
template <class T>
void QuickModelBase<T>::prepend(T data)
{
    beginInsertRows({}, 0, 0);
    mDatas.prepend(data);
	mAllDatas.insert(data);
    endInsertRows();
    updateCalcInfo();
}
template <class T>
void QuickModelBase<T>::insert(int row, const QList<T> &datas)
{
    if (row < 0 || row > mDatas.size())
    {
        return;
    }
    beginInsertRows({}, row, row + datas.count() - 1);
    int srow = row;
    for (const auto &obj : datas)
    {
        mDatas.insert(srow, obj);
		mAllDatas.insert(obj);
        srow++;
    }
    endInsertRows();
    updateCalcInfo();
}
template <class T>
void QuickModelBase<T>::clear()
{
	int mdatacount = mDatas.count();
    if (mdatacount > 0)
    {
		beginRemoveRows({}, 0, mdatacount - 1);
    }
    qDeleteAll(mAllDatas);
    mDatas.clear();
	mAllDatas.clear();

	if (mdatacount > 0)
	{
		endRemoveRows();
	}
    updateCalcInfo();
}
template <class T>
void QuickModelBase<T>::removeAt(int row)
{
    if (row < 0 || row >= mDatas.size())
    {
        return;
    }
    beginRemoveRows({}, row, row);
    auto obj = mDatas.at(row);
    mDatas.removeAt(row);
	mAllDatas.remove(obj);
    endRemoveRows();
    obj->deleteLater();
    updateCalcInfo();
}

template <class T>
void QuickModelBase<T>::subtract(const QSet<T> &other)
{
	if (other.size() == 0)
		return;
	beginResetModel();
	mAllDatas.subtract(other);
	mDatas = mAllDatas.toList();
	endResetModel();
	qDeleteAll(other);
	updateCalcInfo();
}

template <class T>
void QuickModelBase<T>::updateData(int row, T data)
{
    if (row < 0 || row >= mDatas.size())
    {
        return;
    }
    auto oldObj = mDatas.at(row);
    mDatas[row] = data;
	mAllDatas.remove(oldObj);
	mAllDatas.insert(data);
    emit dataChanged(index(row, 0), index(row, 0));
    oldObj->deleteLater();
    updateCalcInfo();
}
