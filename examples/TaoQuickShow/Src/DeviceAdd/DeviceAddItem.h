#pragma once

#include "QuickModel/QuickItemBase.h"
#include <QObject>
class DeviceAddItem : public QuickItemBase
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString address READ address WRITE setAddress NOTIFY addressChanged)
    Q_PROPERTY(QString modelString READ modelString WRITE setModelString NOTIFY modelStringChanged)
    Q_PROPERTY(bool online READ online WRITE setOnline NOTIFY onlineChanged)

public:
    explicit DeviceAddItem(QObject *parent = nullptr);

    const QString &name() const
    {
        return m_name;
    }

    const QString &address() const
    {
        return m_address;
    }

    const QString &modelString() const
    {
        return m_modelString;
    }

    bool online() const
    {
        return m_online;
    }
public slots:
    void setName(const QString &name)
    {
        if (m_name == name)
            return;

        m_name = name;
        emit nameChanged(m_name);
    }

    void setAddress(const QString &address)
    {
        if (m_address == address)
            return;

        m_address = address;
        emit addressChanged(m_address);
    }

    void setModelString(const QString &modelString)
    {
        if (m_modelString == modelString)
            return;

        m_modelString = modelString;
        emit modelStringChanged(m_modelString);
    }

    void setOnline(bool online)
    {
        if (m_online == online)
            return;

        m_online = online;
        emit onlineChanged(m_online);
    }

signals:

    void nameChanged(const QString &name);
    void addressChanged(const QString &address);
    void modelStringChanged(const QString &modelString);
    void onlineChanged(bool online);

private:
    QString m_name;

    QString m_address;

    QString m_modelString;

    bool m_online = false;
};
