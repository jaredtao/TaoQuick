#include "DeviceAddItem.h"
#include <QHostAddress>
DeviceAddItem::DeviceAddItem(QObject* parent)
	: QuickListItemBase(parent)
{
	connect(this, &DeviceAddItem::addressChanged, this, [this]() { m_ipv4Address = QHostAddress(address()).toIPv4Address(); });
}

DeviceAddItem::~DeviceAddItem() { }
bool DeviceAddItem::match(const QString& key)
{
	if (key.isEmpty())
	{
		return true;
	}
	if (m_name.contains(key, Qt::CaseInsensitive))
	{
		return true;
	}
	if (m_address.contains(key, Qt::CaseInsensitive))
	{
		return true;
	}
	if (m_modelString.contains(key, Qt::CaseInsensitive))
	{
		return true;
	}
	return false;
}

bool DeviceAddItem::online() const
{
	return m_online;
}

void DeviceAddItem::set_online(bool newOnline)
{
	if (m_online == newOnline)
		return;
	m_online = newOnline;
	emit onlineChanged();
}

QString DeviceAddItem::modelString() const
{
	return m_modelString;
}

void DeviceAddItem::set_modelString(const QString& newModelString)
{
	if (m_modelString == newModelString)
		return;
	m_modelString = newModelString;
	emit modelStringChanged();
}

QString DeviceAddItem::address() const
{
	return m_address;
}

void DeviceAddItem::set_address(const QString& newAddress)
{
	if (m_address == newAddress)
		return;
	m_address = newAddress;
	emit addressChanged();
}

QString DeviceAddItem::name() const
{
	return m_name;
}

void DeviceAddItem::set_name(const QString& newName)
{
	if (m_name == newName)
		return;
	m_name = newName;
	emit nameChanged();
}
