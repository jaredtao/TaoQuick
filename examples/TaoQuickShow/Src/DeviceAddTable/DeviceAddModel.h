#pragma once

#include <QObject>
#include "QuickModel/QuickListModel.h"
class DeviceAddModelPrivate;
class DeviceAddItem;
class DeviceAddModel : public QuickListModel
{
    Q_OBJECT
public:
    explicit DeviceAddModel(QObject *parent = nullptr);
    virtual ~DeviceAddModel() override;
    Q_INVOKABLE virtual void sortByRole() override;
public slots:
    void doUpdateName(int row, const QString &name);

    void initData();

    void addOne();
    void addMulti(int count);

    void genTxtItems();
    void saveTxtItems();

    void insertBeforeSelected();
    void insertBeforeRow(int row);

    void clearAll();

    void removeSelected();
    void removeChecked();
    void removeRow(int row);
private:
    void sortByName(Qt::SortOrder order);
    void sortByAddress(Qt::SortOrder order);
    void sortByModel(Qt::SortOrder order);

    DeviceAddItem *genOne(uint32_t value);
private:
    DeviceAddModelPrivate *d;
};
