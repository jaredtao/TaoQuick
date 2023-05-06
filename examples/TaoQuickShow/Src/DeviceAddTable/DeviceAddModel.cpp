#include "DeviceAddModel.h"
#include "DeviceAddItem.h"
#include <QCoreApplication>
#include <QEventLoop>
#include <QFile>
#include <QHostAddress>
#include <QString>
#include <chrono>
#include <random>
const static QString	 nameTemplate("item %1");
const static QString	 ipTemplate("%1.%2.%3.%4");
const static QString	 modelTemplate("model %1");
const static QStringList sHeaderRoles = { "name", "address", "modelString" };
class DeviceAddModelPrivate
{
public:
	std::default_random_engine				randomEngine;
	std::uniform_int_distribution<uint32_t> u65535 { 0, 0xffffffff };
};
DeviceAddModel::DeviceAddModel(QObject* parent)
	: QuickListModel(parent)
	, d(new DeviceAddModelPrivate)
{
	set_headerRoles(sHeaderRoles);
	set_sortRole("name");
	QMap<QString, SortCallback> maps;
	maps["name"] = [](QuickListItemBase* b1, QuickListItemBase* b2) -> bool {
		const auto& d1 = static_cast<DeviceAddItem*>(b1);
		const auto& d2 = static_cast<DeviceAddItem*>(b2);
		return d1->name() < d2->name();
	};
	maps["address"] = [](QuickListItemBase* b1, QuickListItemBase* b2) -> bool {
		const auto& d1 = static_cast<DeviceAddItem*>(b1);
		const auto& d2 = static_cast<DeviceAddItem*>(b2);
		return d1->toIPv4Address() < d2->toIPv4Address();
	};
	maps["modelString"] = [](QuickListItemBase* b1, QuickListItemBase* b2) -> bool {
		const auto& d1 = static_cast<DeviceAddItem*>(b1);
		const auto& d2 = static_cast<DeviceAddItem*>(b2);
		return d1->modelString() < d2->modelString();
	};

	QuickListModel::setSortCallbacksAscend(maps);
}

DeviceAddModel::~DeviceAddModel()
{
	delete d;
}

void DeviceAddModel::initData()
{
	const int N = 500;

	QList<QuickListItemBase*> objs;
	objs.reserve(N);
	auto c1 = std::chrono::high_resolution_clock::now();

	for (int i = 0; i < N; ++i)
	{
		auto item = genOne(i);
		objs.append(item);
		//        if (i % 5 == 0)
		//        {
		//            qApp->processEvents(QEventLoop::ExcludeUserInputEvents);
		//        }
	}

	auto c2	   = std::chrono::high_resolution_clock::now();
	auto micro = std::chrono::duration_cast<std::chrono::milliseconds>(c2 - c1).count();
	qWarning() << "general" << N << "cost" << micro << "ms";
	resetData(objs);
	sortByRole();
}

void DeviceAddModel::addOne()
{
	auto item = genOne(d->u65535(d->randomEngine));
	append({ item });
}

void DeviceAddModel::addMulti(int count)
{
	QList<QuickListItemBase*> objs;
	objs.reserve(count);

	for (int i = 0; i < count; ++i)
	{
		auto item = genOne(d->u65535(d->randomEngine));
		objs.push_back(item);
		//        if (i % 5 == 0)
		//        {
		//            qApp->processEvents(QEventLoop::ExcludeUserInputEvents);
		//        }
	}
	append(objs);
}

void DeviceAddModel::insertBeforeSelected()
{
	if (mDatas.count() <= 0)
	{
		auto item = genOne(d->u65535(d->randomEngine));
		insert(0, { item });
	}
	else
	{
		int pos = -1;
		for (int i = 0; i < mDatas.count(); ++i)
		{
			const auto& obj = mDatas.at(i);
			if (obj->isSelected())
			{
				pos = i;
				break;
			}
		}
		if (pos >= 0)
		{
			auto item = genOne(d->u65535(d->randomEngine));
			insert(pos, { item });
		}
	}
}

void DeviceAddModel::insertBeforeRow(int row)
{
	auto item = genOne(d->u65535(d->randomEngine));
	insert(row, { item });
}

void DeviceAddModel::clearAll()
{
	clear();
}

void DeviceAddModel::removeSelected()
{
	for (int i = 0; i < mDatas.count();)
	{
		const auto& obj = mDatas.at(i);
		if (obj->isSelected())
		{
			removeAt(i);
		}
		else
		{
			++i;
		}
	}
}

void DeviceAddModel::removeChecked()
{
	for (int i = 0; i < mDatas.count();)
	{
		const auto& obj = mDatas.at(i);
		if (obj->isChecked())
		{
			removeAt(i);
		}
		else
		{
			++i;
		}
	}
}

void DeviceAddModel::removeRow(int row)
{
	removeAt(row);
}

DeviceAddItem* DeviceAddModel::genOne(uint32_t value)
{
	auto item = new DeviceAddItem;
	item->set_online(value % 2 == 0);
	item->set_name(nameTemplate.arg(value));

	int ip4 = value % 256;
	int ip3 = value / 256 % 256;
	int ip2 = value / 256 / 256 % 256;
	int ip1 = value / 256 / 256 / 256 % 256;
	item->set_address(ipTemplate.arg(ip1).arg(ip2).arg(ip3).arg(ip4));
	item->set_modelString(modelTemplate.arg(value % 2 == 0 ? value : 0xffffffff - value));
	return item;
}
void DeviceAddModel::doUpdateName(int row, const QString& name)
{
	if (row < 0 || row >= rowCount({}))
	{
		return;
	}
	const auto& n = name.simplified();
	if (n.isEmpty())
	{
		return;
	}
	static_cast<DeviceAddItem*>(mDatas.at(row))->set_name(name);
}
