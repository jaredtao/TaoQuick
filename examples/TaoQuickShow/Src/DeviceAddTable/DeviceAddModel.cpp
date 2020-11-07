#include "DeviceAddModel.h"
#include "DeviceAddItem.h"
#include <QHostAddress>
#include <chrono>
#include <random>
const static QString nameTemplate("item %1");
const static QString ipTemplate("%1.%2.%3.%4");
const static QString modelTemplate("model %1");

DeviceAddModel::DeviceAddModel(QObject *parent) : TaoListModel(parent)
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
void DeviceAddModel::initData()
{
    const int N = 500000;

    QList<TaoListItemBase *> objs;
    objs.reserve(N);
    auto c1 = std::chrono::high_resolution_clock::now();

    for (int i = 0; i < N; ++i) {
        auto item = new DeviceAddItem;
        item->setOnline(i % 7 == 0);
        item->setName(nameTemplate.arg(i));

        int ip4 = i % 256;
        int ip3 = i / 256 % 256;
        int ip2 = i / 256 / 256 % 256;
        int ip1 = i / 256 / 256 / 256 % 256;
        item->setAddress(ipTemplate.arg(ip1).arg(ip2).arg(ip3).arg(ip4));
        item->setModelString(modelTemplate.arg(i % 2 == 0 ? i : 0xffffffff - i));
        objs.append(item);
    }

    auto c2 = std::chrono::high_resolution_clock::now();
    auto micro = std::chrono::duration_cast<std::chrono::milliseconds>(c2 - c1).count();
    qWarning() << micro;
    resetData(objs);
}

void DeviceAddModel::addOne()
{
    std::default_random_engine e;
    std::uniform_int_distribution<uint32_t> u65535(0, 0xffffffff);

    uint32_t value = u65535(e);

    auto item = new DeviceAddItem;
    item->setOnline(value % 2 == 0);
    item->setName(nameTemplate.arg(value));

    int ip4 = value % 256;
    int ip3 = value / 256 % 256;
    int ip2 = value / 256 / 256 % 256;
    int ip1 = value / 256 / 256 / 256 % 256;
    item->setAddress(ipTemplate.arg(ip1).arg(ip2).arg(ip3).arg(ip4));
    item->setModelString(modelTemplate.arg(value % 2 == 0 ? value : 0xffffffff - value));
    append({item});
}

void DeviceAddModel::addMulti(int count)
{
    QList<TaoListItemBase *> objs;
    objs.reserve(count);
    std::default_random_engine e;
    std::uniform_int_distribution<uint32_t> u65535(0, 0xffffffff);
    for (int i = 0; i < count; ++i)
    {
        uint32_t value = u65535(e);

        auto item = new DeviceAddItem;
        item->setOnline(value % 2 == 0);
        item->setName(nameTemplate.arg(value));

        int ip4 = value % 256;
        int ip3 = value / 256 % 256;
        int ip2 = value / 256 / 256 % 256;
        int ip1 = value / 256 / 256 / 256 % 256;
        item->setAddress(ipTemplate.arg(ip1).arg(ip2).arg(ip3).arg(ip4));
        item->setModelString(modelTemplate.arg(value % 2 == 0 ? value : 0xffffffff - value));
        objs.push_back(item);
    }
    append(objs);
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
    static_cast<DeviceAddItem *>(mDatas.at(row))->setName(name);
}
