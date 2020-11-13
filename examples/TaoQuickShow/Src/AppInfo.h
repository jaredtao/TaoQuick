#pragma once

#include <QObject>
#include <QString>
#include <QQmlContext>
#include "Common/PropertyHelper.h"
class AppInfo : public QObject
{
    Q_OBJECT

    AUTO_PROPERTY(QString, appName, "")
    AUTO_PROPERTY(QString, appVersion, "")
    AUTO_PROPERTY(QString, latestVersion, "")
    AUTO_PROPERTY(QString, buildDateTime, "")
    AUTO_PROPERTY(QString, buildRevision, "")
    AUTO_PROPERTY(QString, copyRight, "")
    AUTO_PROPERTY(QString, descript, "")
    AUTO_PROPERTY(QString, compilerVendor, "")
    AUTO_PROPERTY(bool, splashShow, false)

public:
    explicit AppInfo(QObject *parent = nullptr);

public:
    void beforeUiReady(QQmlContext *ctx);

    void afterUiReady();

};
