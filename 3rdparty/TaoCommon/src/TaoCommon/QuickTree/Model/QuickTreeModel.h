#pragma once
#include "quicktreeitem.h"
#include <QAbstractItemModel>
#include <QSet>
#include <QVector>
#include "BizCommon_global.h"
class BIZCOMMON_EXPORT QuickTreeModel : public QAbstractItemModel
{
    Q_OBJECT
public:
    explicit QuickTreeModel(QObject *parent = nullptr);
    ~QuickTreeModel();
    QuickTreeItem *rootItem() const
    {
        return m_rootItem;
    }
    QVariant      data(const QModelIndex &index, int role) const override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;
    QVariant      headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;
    QModelIndex   index(int row, int column, const QModelIndex &parent = QModelIndex()) const override;
    QModelIndex   parent(const QModelIndex &index) const override;
    int           rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int           columnCount(const QModelIndex &parent = QModelIndex()) const override;

    //[begin] add data
    void appendChild(QuickTreeItem *data)
    {
        beginInsertRows({}, m_rootItem->childCount(), m_rootItem->childCount() + 1);
        m_rootItem->appendChild(data);
        endInsertRows();
    }
    void appendChildren(const QVector<QuickTreeItem *> &datas)
    {
        beginInsertRows({}, m_rootItem->childCount(), m_rootItem->childCount() + datas.size() - 1);
        m_rootItem->appendChildren(datas);
        endInsertRows();
    }
	void prependChild(QuickTreeItem *data)
	{
        beginInsertRows({}, 0, 0);
        m_rootItem->prependChild(data);
        endInsertRows();
	}
    void insert(int row, const QVector<QuickTreeItem *> &datas)
    {
        if (row < 0 || row > m_rootItem->childCount())
        {
            return;
        }
        beginInsertRows({}, m_rootItem->childCount(), m_rootItem->childCount() + datas.size() - 1);
        m_rootItem->insert(row, datas);
        endInsertRows();
    }
    //[end] add data

    //[begin] remove data
    void clear()
    {
        if (m_rootItem->childCount() > 0)
        {
            beginRemoveRows({}, 0, m_rootItem->childCount() - 1);
            m_rootItem->clear();
            endRemoveRows();
        }
    }
    void removeAt(int row)
    {
        if (row < 0 || row >= m_rootItem->childCount())
        {
            return;
        }
        beginRemoveRows({}, row, row);
        m_rootItem->removeAt(row);
        endRemoveRows();
    }
    //[end] remove data

    //    //[begin] update data
    //    void updateData(int row, int column, QVariant data)
    //    {
    //      emit dataChanged(index(row, 0), index(row, 0));
    //    }
    //    //[end] update data

private:
    QuickTreeItem *m_rootItem;
};
