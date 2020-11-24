#include "DeviceAddModel.h"
#include "DeviceAddItem.h"
#include <QHostAddress>
#include <QCoreApplication>
#include <QEventLoop>
#include <chrono>
#include <random>
const static QString nameTemplate("item %1");
const static QString ipTemplate("%1.%2.%3.%4");
const static QString modelTemplate("model %1");
class DeviceAddModelPrivate
{
public:
    std::default_random_engine randomEngine;
    std::uniform_int_distribution<uint32_t> u65535 { 0, 0xffffffff };
};
DeviceAddModel::DeviceAddModel(QObject *parent) : TaoListModel(parent), d(new DeviceAddModelPrivate)
{
    setHeaderRoles({ "name", "address", "modelString" });
    QMap<QString, SortCallback> callBacks;
    callBacks["name"] = [](TaoListItemBase *b1, TaoListItemBase *b2) -> bool {
        return (static_cast<DeviceAddItem *>(b1))->name()
                < (static_cast<DeviceAddItem *>(b2))->name();
    };
    callBacks["address"] = [](TaoListItemBase *b1, TaoListItemBase *b2) -> bool {
        QHostAddress add1(static_cast<DeviceAddItem *>(b1)->address());
        QHostAddress add2(static_cast<DeviceAddItem *>(b2)->address());
        return add1.toIPv4Address() < add2.toIPv4Address();
    };
    callBacks["modelString"] = [](TaoListItemBase *b1, TaoListItemBase *b2) -> bool {
        const QString &s1 = static_cast<DeviceAddItem *>(b1)->modelString();
        const QString &s2 = static_cast<DeviceAddItem *>(b2)->modelString();
        auto m1 = s1.mid(6, s1.length() - 6).toInt();
        auto m2 = s2.mid(6, s2.length() - 6).toInt();
        return m1 < m2;
    };
    setSortCallbacks(callBacks);
}

DeviceAddModel::~DeviceAddModel()
{
    delete d;
}
void DeviceAddModel::initData()
{
    const int N = 50000;

    QList<TaoListItemBase *> objs;
    objs.reserve(N);
    auto c1 = std::chrono::high_resolution_clock::now();

    for (int i = 0; i < N; ++i) {
        auto item = genOne(i);
        objs.append(item);
//        if (i % 5 == 0)
//        {
//            qApp->processEvents(QEventLoop::ExcludeUserInputEvents);
//        }
    }

    auto c2 = std::chrono::high_resolution_clock::now();
    auto micro = std::chrono::duration_cast<std::chrono::milliseconds>(c2 - c1).count();
    qWarning() << "general" << N << "cost" << micro << "ms";
    resetData(objs);
}

void DeviceAddModel::addOne()
{
    auto item = genOne(d->u65535(d->randomEngine));
    append({ item });
}

void DeviceAddModel::addMulti(int count)
{
    QList<TaoListItemBase *> objs;
    objs.reserve(count);

    for (int i = 0; i < count; ++i) {
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
    if (mDatas.count() <= 0) {
        auto item = genOne(d->u65535(d->randomEngine));
        insert(0, { item });
    } else {
        int pos = -1;
        for (int i = 0; i < mDatas.count(); ++i) {
            const auto &obj = mDatas.at(i);
            if (obj->isVisible() && obj->isSelected()) {
                pos = i;
                break;
            }
        }
        if (pos >= 0) {
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
        const auto &obj = mDatas.at(i);
        if (obj->isVisible() && obj->isSelected())
        {
            removeAt(i);
        } else {
            ++i;
        }
    }
}

void DeviceAddModel::removeChecked()
{
    for (int i = 0; i < mDatas.count();)
    {
        const auto &obj = mDatas.at(i);
        if (obj->isVisible() && obj->isChecked())
        {
            removeAt(i);
        } else {
            ++i;
        }
    }
}

void DeviceAddModel::removeRow(int row)
{
    removeAt(row);
}

DeviceAddItem *DeviceAddModel::genOne(uint32_t value)
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
void DeviceAddModel::doUpdateName(int row, const QString &name)
{
    if (row < 0 || row >= rowCount({})) {
        return;
    }
    const auto &n = name.simplified();
    if (n.isEmpty()) {
        return;
    }
    static_cast<DeviceAddItem *>(mDatas.at(row))->set_name(name);
}
