#pragma once

#include "TaoModel/TaoListItemBase.h"
#include"Common/PropertyHelper.h"
#include <QObject>
class DeviceAddItem : public TaoListItemBase
{
    Q_OBJECT

    AUTO_PROPERTY(QString, name, "")
    AUTO_PROPERTY(QString, address, "")
    AUTO_PROPERTY(QString, modelString, "")
    AUTO_PROPERTY(bool, online, false)
public:
    explicit DeviceAddItem(QObject *parent = nullptr);
    virtual ~DeviceAddItem() override;

    bool match(const QString &key) override;
private:

};
