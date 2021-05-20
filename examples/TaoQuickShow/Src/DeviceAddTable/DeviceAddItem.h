#pragma once

#include "Common/PropertyHelper.h"
#include "QuickModel/QuickListItemBase.h"
#include <QObject>
class DeviceAddItem : public QuickListItemBase
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
    quint32 toIPv4Address() const { return m_ipv4Address; }

private:
    quint32 m_ipv4Address = 0;
};
