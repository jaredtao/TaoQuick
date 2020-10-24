#pragma once

#include <QObject>
#include <QString>
#include <QQmlContext>
class AppInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString appName READ appName WRITE setAppName NOTIFY appNameChanged)
    Q_PROPERTY(QString appVersion READ appVersion WRITE setAppVersion NOTIFY appVersionChanged)
    Q_PROPERTY(QString latestVersion READ latestVersion WRITE setLatestVersion NOTIFY
                       latestVersionChanged)
    Q_PROPERTY(QString buildDateTime READ buildDateTime WRITE setBuildDateTime NOTIFY
                       buildDateTimeChanged)
    Q_PROPERTY(QString buildRevision READ buildRevision WRITE setBuildRevision NOTIFY
                       buildRevisionChanged)
    Q_PROPERTY(QString copyRight READ copyRight WRITE setCopyRight NOTIFY copyRightChanged)
    Q_PROPERTY(QString descript READ descript WRITE setDescript NOTIFY descriptChanged)
    Q_PROPERTY(QString compilerVendor READ compilerVendor WRITE setCompilerVendor NOTIFY
                       compilerVendorChanged)

    Q_PROPERTY(bool splashShow READ splashShow WRITE setSplashShow NOTIFY splashShowChanged)
public:
    explicit AppInfo(QObject *parent = nullptr);

public:
    void beforeUiReady(QQmlContext *ctx);

    void afterUiReady();

    const QString &appName() const { return m_appName; }

    const QString &appVersion() const { return m_appVersion; }

    const QString &latestVersion() const { return m_latestVersion; }

    const QString &buildDateTime() const { return m_buildDateTime; }

    const QString &buildRevision() const { return m_buildRevision; }

    const QString &copyRight() const { return m_copyRight; }

    const QString &descript() const { return m_descript; }

    const QString &compilerVendor() const { return m_compilerVendor; }

    bool splashShow() const { return m_splashShow; }

public slots:

    void setAppName(const QString &appName);

    void setAppVersion(const QString &appVersion);

    void setLatestVersion(const QString &latestVersion);

    void setBuildDateTime(const QString &buildDateTime);

    void setBuildRevision(const QString &buildRevision);

    void setCopyRight(const QString &copyRight);

    void setDescript(const QString &descript);

    void setCompilerVendor(const QString &compilerVendor);

    void setSplashShow(bool splashShow);

signals:

    void appNameChanged(const QString &appName);

    void appVersionChanged(const QString &appVersion);

    void latestVersionChanged(const QString &latestVersion);

    void buildDateTimeChanged(const QString &buildDateTime);

    void buildRevisionChanged(const QString &buildRevision);

    void copyRightChanged(const QString &copyRight);

    void descriptChanged(const QString &descript);

    void compilerVendorChanged(const QString &compilerVendor);

    void splashShowChanged(bool splashShow);

protected:
private:
    QString m_appName;
    QString m_appVersion;
    QString m_latestVersion;
    QString m_buildDateTime;
    QString m_buildRevision;
    QString m_copyRight;
    QString m_descript;
    QString m_compilerVendor;
    bool m_splashShow;
};
