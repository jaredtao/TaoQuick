#pragma once

#include "TaoCommonGlobal.h"
#include <QObject>
#include <QVariant>
#include <QVector>
class TAO_API QuickTreeItem : public QObject
{
	Q_OBJECT
public:
	explicit QuickTreeItem(QuickTreeItem* parentItem = nullptr) : m_parentItem(parentItem) {}
	explicit QuickTreeItem(const QVector<QVariant>& data, QuickTreeItem* parentItem = nullptr) : m_itemData(data), m_parentItem(parentItem) {}

	virtual ~QuickTreeItem()
	{
		qDeleteAll(m_childItems);
	}

	void appendChild(QuickTreeItem* child)
	{
		m_childItems.append(child);
	}
	void prependChild(QuickTreeItem* child)
	{
		m_childItems.prepend(child);
	}
	void appendChildren(const QVector<QuickTreeItem*>& children)
	{
		m_childItems.append(children);
	}
	void insert(int row, const QVector<QuickTreeItem*>& children)
	{
		if (0 <= row && 0 < m_childItems.size())
		{
			for (int j = 0; j < children.size(); ++j)
			{
				m_childItems.insert(row + j, children[j]);
			}
		}
	}
	void insert(int row, QuickTreeItem* child)
	{
		if (0 <= row && row < m_childItems.size())
		{
			m_childItems.insert(row, child);
		}
	}
	void clear()
	{
		qDeleteAll(m_childItems);
		m_childItems.clear();
		m_itemData.clear();
	}
	void removeAt(int row)
	{
		if (0 <= row && row < m_childItems.size())
		{
			delete m_childItems.at(row);
			m_childItems.removeAt(row);
		}
	}

	QuickTreeItem* child(int row)
	{
		if (row < 0 || row >= m_childItems.size())
			return nullptr;
		return m_childItems.at(row);
	}
	int childCount() const
	{
		return m_childItems.count();
	}
	int columnCount() const
	{
		return m_itemData.count();
	}

	QVariant data(int column) const
	{
		if (0 <= column && column < m_itemData.size())
		{
			return m_itemData.at(column);
		}
		return {};
	}
	void setDatas(const QVector<QVariant>& datas)
	{
		m_itemData = datas;
	}
	void setData(int index, const QVariant& data)
	{
		if (0 <= index && index < m_itemData.size())
		{
			m_itemData[index] = data;
		}
	}
	int row() const
	{
		if (m_parentItem)
			return m_parentItem->m_childItems.indexOf(const_cast<QuickTreeItem*>(this));
		return 0;
	}

	QuickTreeItem* parentItem() const
	{
		return m_parentItem;
	}

private:
	QVector<QuickTreeItem*> m_childItems;
	QVector<QVariant>		m_itemData;
	QuickTreeItem*			m_parentItem = nullptr;
};
