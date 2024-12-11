#pragma once

#include "Common/JsonSerialize.h"
#include "Common/PropertyHelper.h"
#include <QObject>
#include <QQmlContext>
#include <QString>
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

public:
	explicit AppInfo(QObject* parent = nullptr);
	virtual ~AppInfo() override;

public:
	void beforeUiReady(QQmlContext* ctx);

	void afterUiReady();
};
