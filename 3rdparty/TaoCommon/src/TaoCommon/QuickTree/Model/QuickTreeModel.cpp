#include "QuickTreeModel.h"
QuickTreeModel::QuickTreeModel(QObject* parent) : QAbstractItemModel(parent)
{
	m_rootItem = new QuickTreeItem(nullptr);
	QVector<QVariant> datas;
	datas.append("");
	datas.append("");
	datas.append("");
	datas.append("");
	m_rootItem->setDatas(datas);
}

QuickTreeModel::~QuickTreeModel()
{
	delete m_rootItem;
}

QVariant QuickTreeModel::data(const QModelIndex& index, int role) const
{
	if (!index.isValid())
		return QVariant();

	if (role != Qt::DisplayRole)
		return QVariant();

	QuickTreeItem* item = static_cast<QuickTreeItem*>(index.internalPointer());

	return item->data(index.column());
}

Qt::ItemFlags QuickTreeModel::flags(const QModelIndex& index) const
{
	if (!index.isValid())
		return Qt::NoItemFlags;

	return QAbstractItemModel::flags(index);
}

QVariant QuickTreeModel::headerData(int section, Qt::Orientation orientation, int role) const
{
	if (orientation == Qt::Horizontal && role == Qt::DisplayRole)
		return m_rootItem->data(section);

	return QVariant();
}

QModelIndex QuickTreeModel::index(int row, int column, const QModelIndex& parent) const
{
	if (!hasIndex(row, column, parent))
		return QModelIndex();

	QuickTreeItem* parentItem;

	if (!parent.isValid())
		parentItem = m_rootItem;
	else
		parentItem = static_cast<QuickTreeItem*>(parent.internalPointer());

	QuickTreeItem* childItem = parentItem->child(row);
	if (childItem)
		return createIndex(row, column, childItem);
	return QModelIndex();
}

QModelIndex QuickTreeModel::parent(const QModelIndex& index) const
{
	if (!index.isValid())
		return QModelIndex();

	QuickTreeItem* childItem  = static_cast<QuickTreeItem*>(index.internalPointer());
	QuickTreeItem* parentItem = childItem->parentItem();

	if (parentItem == m_rootItem)
		return QModelIndex();

	return createIndex(parentItem->row(), 0, parentItem);
}

int QuickTreeModel::rowCount(const QModelIndex& parent) const
{
	QuickTreeItem* parentItem;
	if (parent.column() > 0)
		return 0;

	if (!parent.isValid())
		parentItem = m_rootItem;
	else
		parentItem = static_cast<QuickTreeItem*>(parent.internalPointer());

	return parentItem->childCount();
}

int QuickTreeModel::columnCount(const QModelIndex& parent) const
{
	if (parent.isValid())
		return static_cast<QuickTreeItem*>(parent.internalPointer())->columnCount();
	return m_rootItem->columnCount();
}
