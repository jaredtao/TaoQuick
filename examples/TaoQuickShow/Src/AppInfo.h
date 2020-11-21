#pragma once

#include <QObject>
#include <QString>
#include <QQmlContext>
#include "Common/PropertyHelper.h"
#include "Common/JsonSerialize.h"
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
    AUTO_PROPERTY(float, scale, 1.0f)
    AUTO_PROPERTY(double, ratio, 14.0 / 9.0)
    AUTO_PROPERTY(QStringList, customs, {})

    JsonSerialize_Begin()
        JsonProperty(appName)
        JsonProperty(appVersion)
        JsonProperty(latestVersion)
        JsonProperty(buildDateTime)
        JsonProperty(buildRevision)
        JsonProperty(copyRight)
        JsonProperty(descript)
        JsonProperty(compilerVendor)
        JsonProperty(splashShow)
        JsonProperty(scale)
        JsonProperty(ratio)
        JsonContainerProperty(customs)
    JsonSerialize_End()

    JsonDeserialize_Begin(AppInfo)
        JsonDeserializeProperty(appName)
        JsonDeserializeProperty(appVersion)
        JsonDeserializeProperty(latestVersion)
        JsonDeserializeProperty(buildDateTime)
        JsonDeserializeProperty(buildRevision)
        JsonDeserializeProperty(copyRight)
        JsonDeserializeProperty(descript)
        JsonDeserializeProperty(compilerVendor)
        JsonDeserializeProperty(splashShow)
        JsonDeserializeProperty(scale)
        JsonDeserializeProperty(ratio)
        JsonDeserializeContainerProperty(customs)
    JsonDeserialize_End()


    JsonPartialDeserialize_Begin(AppInfo)
        JsonDeserializeProperty(appName)
        JsonDeserializeProperty(appVersion)
        JsonDeserializeProperty(latestVersion)
        JsonDeserializeProperty(buildDateTime)
        JsonDeserializeProperty(buildRevision)
        JsonDeserializeProperty(copyRight)
        JsonDeserializeProperty(descript)
        JsonDeserializeProperty(compilerVendor)
        JsonDeserializeProperty(splashShow)
        JsonDeserializeProperty(scale)
        JsonDeserializeProperty(ratio)
        JsonDeserializeContainerProperty(customs)
    JsonPartialDeserialize_End()

public:
    explicit AppInfo(QObject *parent = nullptr);
    virtual ~AppInfo() override;
public:
    void beforeUiReady(QQmlContext *ctx);

    void afterUiReady();
};
