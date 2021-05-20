#include "DeviceAddModel.h"
#include "DeviceAddItem.h"
#include <QCoreApplication>
#include <QEventLoop>
#include <QHostAddress>
#include <QFile>
#include <QString>
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
DeviceAddModel::DeviceAddModel(QObject *parent) : QuickListModel(parent), d(new DeviceAddModelPrivate)
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

    QList<QuickListItemBase *> objs;
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
    QList<QuickListItemBase *> objs;
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
    QList<QuickListItemBase *> copyObjs = mDatas;
    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return (static_cast<DeviceAddItem *>(obj1))->name() < (static_cast<DeviceAddItem *>(obj2))->name();
        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return (static_cast<DeviceAddItem *>(obj1))->name() > (static_cast<DeviceAddItem *>(obj2))->name();
        });
    }
    mDatas = copyObjs;
    emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}

void DeviceAddModel::sortByAddress(Qt::SortOrder order)
{
    QList<QuickListItemBase *> copyObjs = mDatas;
    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [=](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return static_cast<DeviceAddItem *>(obj1)->toIPv4Address() < static_cast<DeviceAddItem *>(obj2)->toIPv4Address();
        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [=](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return static_cast<DeviceAddItem *>(obj1)->toIPv4Address() > static_cast<DeviceAddItem *>(obj2)->toIPv4Address();
        });
    }
    mDatas = copyObjs;
    emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
}

void DeviceAddModel::sortByModel(Qt::SortOrder order)
{
    QList<QuickListItemBase *> copyObjs = mDatas;
    if (order == Qt::SortOrder::AscendingOrder) {
        std::sort(copyObjs.begin(), copyObjs.end(), [](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return (static_cast<DeviceAddItem *>(obj1))->modelString().toULongLong() < (static_cast<DeviceAddItem *>(obj2))->modelString().toULongLong();
        });
    } else {
        std::sort(copyObjs.begin(), copyObjs.end(), [](QuickListItemBase *obj1, QuickListItemBase *obj2) -> bool {
            return (static_cast<DeviceAddItem *>(obj1))->modelString().toULongLong() > (static_cast<DeviceAddItem *>(obj2))->modelString().toULongLong();
        });
    }
    mDatas = copyObjs;
    emit dataChanged(index(0, 0), index(mDatas.count() - 1, 0));
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


void DeviceAddModel::saveTxtItems()
{
    QFile file("testdata.txt");
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        qDebug()<<"testdata.txt no exit!";
        return ;
    }

    QTextStream out(&file);
    qDebug()<<"saveTxtItems--->mDatas.count()"<< mDatas.count();
    if (mDatas.count() <= 0) {
        qDebug()<<"mDatas.count() is null!";
    }
    else
    {
        for (int i = 0; i < mDatas.count(); ++i) {
            const auto &obj = mDatas.at(i);
            if (obj->isVisible() && obj->isChecked())
            {
                auto name= static_cast<DeviceAddItem *>(obj)->name();
                auto address= static_cast<DeviceAddItem *>(obj)->address();
                auto modelString= static_cast<DeviceAddItem *>(obj)->modelString();

                qDebug()<<"saveTxtItems--->name"<< name;
                out << name << ";"
                    << address << ";"
                    << modelString << ";"
                    << "\n";
            }
        }
    }
}

void DeviceAddModel::genTxtItems()
{
    QList<QuickListItemBase *> objs;
//    objs.reserve(count);

    QFile file("testdata.txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        qDebug()<<"testdata.txt no exit!";
        return ;
    }
    QTextStream in(&file);
    while (!in.atEnd())
    {
        QString line = in.readLine();
        auto words=line.split(';', QString::SkipEmptyParts);
        int count = 0;
        for(auto word:words){
            word=word.trimmed();
            ++count;
        }
        qDebug()<<"count"<<count;

        if(count == 3)
        {
            auto item = new DeviceAddItem;
            item->set_name(nameTemplate.arg(words[0]));
            auto ip=words[1].split('.', QString::SkipEmptyParts);
            int ipcount = 0;
            for(auto ipitem:ip){
                ipitem=ipitem.trimmed();
                ++ipcount;
            }
            qDebug()<<"ip"<<ip;
            if(ipcount==4)
            {
                item->set_address(ipTemplate.arg(ip[0])
                                            .arg(ip[1])
                                            .arg(ip[2])
                                            .arg(ip[3]));
            }
            item->set_modelString(modelTemplate.arg(words[2]));
            objs.append(item);
        }
    }
    qDebug()<<"append(objs)";
    append(objs);
}
