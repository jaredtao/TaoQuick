#pragma once

#include <QObject>
#include "TaoModel/TaoListModel.h"
class DeviceAddModelPrivate;
class DeviceAddItem;
class DeviceAddModel : public TaoListModel
{
    Q_OBJECT
public:
    explicit DeviceAddModel(QObject *parent = nullptr);
    virtual ~DeviceAddModel() override;
public slots:
    void doUpdateName(int row, const QString &name);

    void initData();

    void addOne();
    void addMulti(int count);

    void insertBeforeSelected();
    void insertBeforeRow(int row);

    void clearAll();

    void removeSelected();
    void removeChecked();
    void removeRow(int row);
private:
    DeviceAddItem *genOne(uint32_t value);
private:
    DeviceAddModelPrivate *d;
};

