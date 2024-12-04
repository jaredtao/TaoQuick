#pragma once

#include "Common/PropertyHelper.h"
#include "QuickModel/QuickListItemBase.h"
#include <QObject>
class DeviceAddItem : public QuickListItemBase
{
	Q_OBJECT

	AUTO_PROPERTY_V2(QString, name, "")
	AUTO_PROPERTY_V2(QString, address, "")
	AUTO_PROPERTY_V2(QString, modelString, "")
	AUTO_PROPERTY_V2(bool, online, false)
signals:
	void nameChanged(const QString&);
	void addressChanged(const QString&);
	void modelStringChanged(const QString&);
	void onlineChanged(bool);

public:
	explicit DeviceAddItem(QObject* parent = nullptr);
	virtual ~DeviceAddItem() override;

	bool	match(const QString& key) override;
	quint32 toIPv4Address() const
	{
		return m_ipv4Address;
	}

private:
	quint32 m_ipv4Address = 0;
};
