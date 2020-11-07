#include "DeviceAddModel.h"
#include "DeviceAddItem.h"
#include <QHostAddress>
#include <chrono>
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
    QList<TaoListItemBase *> objs;
    uint64_t num = 0;
    const int N = 1000;
    DeviceAddItem *pItem = new DeviceAddItem[N];
    auto c1 = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < 256; ++i) {
        for (int j = 0; j < 256; ++j) {
            for (int k = 0; k < 256; ++k) {
                for (int l = 0; l < 256; ++l) {

                    auto item = pItem + num;
                    item->setOnline(num % 7 == 0);
                    item->setName(QString("item %1").arg(num));
                    item->setAddress(QString("%1.%2.%3.%4").arg(i).arg(j).arg(k).arg(l));
                    item->setModelString(
                            QString("model %1").arg(num % 2 == 0 ? num : 0xffffffff - num));
                    objs.append(item);
                    num++;
                    if (num >= N) {
                        goto over;
                    }
                }
            }
        }
    }
over:
    auto c2 = std::chrono::high_resolution_clock::now();
    auto micro = std::chrono::duration_cast<std::chrono::milliseconds>(c2 - c1).count();
    qWarning() << micro;
    resetData(objs);
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
