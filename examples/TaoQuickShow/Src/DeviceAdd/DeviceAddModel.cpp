#include "DeviceAddModel.h"
#include "DeviceAddItem.h"
#include <QHostAddress>
DeviceAddModel::DeviceAddModel(QObject *parent)
    : TaoListModel(parent)
{
    QList<TaoListItemBase *> objs;
    for (int i = 0; i < 20; ++i) {
        auto item = new DeviceAddItem;
        item->setOnline(i % 7 == 0);
        item->setName(QString("item %1").arg(i));
        item->setAddress(QString("192.168.1.%1").arg(100 - i));
        item->setModelString(QString("model %1").arg(i % 2 == 0 ? i : 100 - i));
        objs.append(item);
    }
    resetData(objs);
    setHeaderRoles({ "name", "address", "modelString" });
    QMap<QString, SortCallback> callBacks;
    callBacks["name"]
        = [](TaoListItemBase *b1, TaoListItemBase *b2) -> bool { return (static_cast<DeviceAddItem *>(b1))->name() < (static_cast<DeviceAddItem *>(b2))->name(); };
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

void DeviceAddModel::doUpdateName(int row, const QString &name)
{
    if (row < 0 || row >= rowCount({}))
    {
        return;
    }
    const auto &n = name.simplified();
    if (n.isEmpty())
    {
        return;
    }
    static_cast<DeviceAddItem *>(mDatas.at(row))->setName(name);
}
