#include "DeviceAddItem.h"
#include <QHostAddress>
DeviceAddItem::DeviceAddItem(QObject *parent) : QuickListItemBase(parent)
{
    connect(this, &DeviceAddItem::addressChanged, this, [this]() { m_ipv4Address = QHostAddress(address()).toIPv4Address(); });
}

DeviceAddItem::~DeviceAddItem() { }
bool DeviceAddItem::match(const QString &key)
{
    if (key.isEmpty()) {
        return true;
    }
    if (m_name.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    if (m_address.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    if (m_modelString.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    return false;
}
