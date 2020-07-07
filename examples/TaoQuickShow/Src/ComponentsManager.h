#pragma once

#include <QObject>
#include <QString>
#include "TaoObject.h"
#include <QJsonArray>
class ComponentsMgr : public QObject, public TaoObject
{
    Q_OBJECT
    Q_PROPERTY(QJsonArray comps READ comps WRITE setComps NOTIFY compsChanged)
public:
    explicit ComponentsMgr(QObject *parent = nullptr);
    Q_INVOKABLE void loadFolder(const QString &folder);
public:
    void init() override;

    void uninit() override;

    void beforeUiReady(QQmlContext* ctx) override;

    void afterUiReady() override;

    const QJsonArray &comps() const;

public slots:
    void setComps(const QJsonArray &comps);

signals:
    void compsChanged(QJsonArray comps);

protected:

private:

    QJsonArray m_comps;
};

