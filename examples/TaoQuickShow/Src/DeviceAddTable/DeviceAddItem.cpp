#include "DeviceAddItem.h"

DeviceAddItem::DeviceAddItem(QObject *parent) : TaoListItemBase(parent) { }

DeviceAddItem::~DeviceAddItem() { }
bool DeviceAddItem::match(const QString &key)
{
    if (key.isEmpty()) {
        return true;
    }
    if (m_name.contains(key, Qt::CaseInsensitive)) {
        return true;
    } else if (m_address.contains(key, Qt::CaseInsensitive)) {
        return true;
    } else if (m_modelString.contains(key, Qt::CaseInsensitive)) {
        return true;
    }
    return false;
}
