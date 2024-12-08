#pragma once

#include "Common/PropertyHelper.h"
#include "QuickModel/QuickListItemBase.h"
#include <QObject>
class DeviceAddItem : public QuickListItemBase
{
	Q_OBJECT

	Q_PROPERTY(QString name READ name WRITE set_name NOTIFY nameChanged FINAL)
	Q_PROPERTY(QString address READ address WRITE set_address NOTIFY addressChanged FINAL)
	Q_PROPERTY(QString modelString READ modelString WRITE set_modelString NOTIFY modelStringChanged FINAL)
	Q_PROPERTY(bool online READ online WRITE set_online NOTIFY onlineChanged FINAL)
	// 	AUTO_PROPERTY_V2(QString, name, "")
	// 	AUTO_PROPERTY_V2(QString, address, "")
	// 	AUTO_PROPERTY_V2(QString, modelString, "")
	// 	AUTO_PROPERTY_V2(bool, online, false)
	// signals:
	// 	void nameChanged(const QString&);
	// 	void addressChanged(const QString&);
	// 	void modelStringChanged(const QString&);
	// 	void onlineChanged(bool);

public:
	explicit DeviceAddItem(QObject* parent = nullptr);
	virtual ~DeviceAddItem() override;

	bool	match(const QString& key) override;
	quint32 toIPv4Address() const
	{
		return m_ipv4Address;
	}

	bool online() const;
	void set_online(bool newOnline);

	QString modelString() const;
	void	set_modelString(const QString& newModelString);

	QString address() const;
	void	set_address(const QString& newAddress);

	QString name() const;
	void	set_name(const QString& newName);

signals:
	void onlineChanged();

	void modelStringChanged();

	void addressChanged();

	void nameChanged();

private:
	quint32 m_ipv4Address = 0;
	bool	m_online;
	QString m_modelString;
	QString m_address;
	QString m_name;
};
