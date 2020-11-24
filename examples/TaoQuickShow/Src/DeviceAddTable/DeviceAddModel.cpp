#include "DeviceAddModel.h"
#include "DeviceAddItem.h"
#include <QCoreApplication>
#include <QEventLoop>
#include <QHostAddress>
#include <chrono>
#include <random>
const static QString nameTemplate("item %1");
const static QString ipTemplate("%1.%2.%3.%4");
const static QString modelTemplate("model %1");
const static QStringList sHeaderRoles = { "name", "address", "modelString" };
class DeviceAddModelPrivate
{
public:
    std::default_random_engine randomEngine;
    std::uniform_int_distribution<uint32_t> u65535 { 0, 0xffffffff };
};
DeviceAddModel::DeviceAddModel(QObject *parent) : TaoListModel(parent), d(new DeviceAddModelPrivate)
{
    setHeaderRoles(sHeaderRoles);

}

DeviceAddModel::~DeviceAddModel()
{
    delete d;
}

void DeviceAddModel::sortByRole()
{
    if (mDatas.count() <= 1) {
        return;
    }
    int index = sHeaderRoles.indexOf(mSortRole);
    switch (index) {
    case 0: {
        sortByName(mSortOrder);
        break;
    }
    case 1: {
        sortByAddress(mSortOrder);
        break;
    }
    case 2: {
        sortByModel(mSortOrder);
        break;
    }
    default:
        break;
    }
    updateAlternate();
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
    for (int i = 0; i < mDatas.count();) {
        const auto &obj = mDatas.at(i);
        if (obj->isVisible() && obj->isSelected()) {
            removeAt(i);
        } else {
            ++i;
        }
    }
}

void DeviceAddModel::removeChecked()
{
    for (int i = 0; i < mDatas.count();) {
        const auto &obj = mDatas.at(i);
        if (obj->isVisible() && obj->isChecked()) {
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

void DeviceAddModel::sortByName(Qt::SortOrder order)
{
    QList<TaoListItemBase *> copyObjs = mDatas;
    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [](TaoListItemBase *obj1, TaoListItemBase *obj2) -> bool {
            return (static_cast<DeviceAddItem *>(obj1))->name() < (static_cast<DeviceAddItem *>(obj2))->name();
        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [](TaoListItemBase *obj1, TaoListItemBase *obj2) -> bool {
            return (static_cast<DeviceAddItem *>(obj1))->name() > (static_cast<DeviceAddItem *>(obj2))->name();
        });
    }
    beginResetModel();
    mDatas = copyObjs;
    endResetModel();
}

void DeviceAddModel::sortByAddress(Qt::SortOrder order)
{
    const auto addressToUint = [](const QString &address)->uint32_t {
        auto list = address.split('.');
        if (list.size() != 4) {
            return 0;
        }
        return list.at(0).toUInt() * 256^3 + list.at(1).toUInt()* 256^2 + list.at(2).toUInt()* 256 + list.at(3).toUInt();
    };
    QList<TaoListItemBase *> copyObjs = mDatas;
    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [=](TaoListItemBase *obj1, TaoListItemBase *obj2) -> bool {
            return addressToUint(static_cast<DeviceAddItem *>(obj1)->address()) < addressToUint(static_cast<DeviceAddItem *>(obj2)->address());
        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [=](TaoListItemBase *obj1, TaoListItemBase *obj2) -> bool {
            return addressToUint(static_cast<DeviceAddItem *>(obj1)->address()) > addressToUint(static_cast<DeviceAddItem *>(obj2)->address());
        });
    }
    beginResetModel();
    mDatas = copyObjs;
    endResetModel();
}

void DeviceAddModel::sortByModel(Qt::SortOrder order)
{
    QList<TaoListItemBase *> copyObjs = mDatas;
    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [](TaoListItemBase *obj1, TaoListItemBase *obj2) -> bool {
            return (static_cast<DeviceAddItem *>(obj1))->modelString().toULongLong() < (static_cast<DeviceAddItem *>(obj2))->modelString().toULongLong();
        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [](TaoListItemBase *obj1, TaoListItemBase *obj2) -> bool {
            return (static_cast<DeviceAddItem *>(obj1))->modelString().toULongLong() > (static_cast<DeviceAddItem *>(obj2))->modelString().toULongLong();
        });
    }
    beginResetModel();
    mDatas = copyObjs;
    endResetModel();
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
