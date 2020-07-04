#include "AppInfo.h"
#include <QQmlContext>
#include "Ver-u8.h"
AppInfo::AppInfo(QObject *parent) : QObject(parent)
{
    m_appName = VER_PRODUCTNAME_STR;
    m_appVersion = TaoVer;
    m_latestVersion = TaoVer;
    m_buildDateTime = TaoDATETIME;
    m_buildRevision = TaoREVISIONSTR;
    m_copyRight = VER_LEGALCOPYRIGHT_STR;
    m_descript = QString::fromLocal8Bit(VER_FILEDESCRIPTION_STR);
    m_compilerVendor = TaoCompilerVendor;
}

void AppInfo::init()
{

}

void AppInfo::uninit()
{

}

void AppInfo::beforeUiReady(QQmlContext *ctx)
{
    ctx->setContextProperty("appInfo", this);
}

void AppInfo::afterUiReady()
{

}

void AppInfo::setAppName(const QString &appName)
{
    if (m_appName == appName)
        return;

    m_appName = appName;
    emit appNameChanged(m_appName);
}

void AppInfo::setAppVersion(const QString &appVersion)
{
    if (m_appVersion == appVersion)
        return;

    m_appVersion = appVersion;
    emit appVersionChanged(m_appVersion);
}

void AppInfo::setLatestVersion(const QString &latestVersion)
{
    if (m_latestVersion == latestVersion)
        return;

    m_latestVersion = latestVersion;
    emit latestVersionChanged(m_latestVersion);
}

void AppInfo::setBuildDateTime(const QString &buildDateTime)
{
    if (m_buildDateTime == buildDateTime)
        return;

    m_buildDateTime = buildDateTime;
    emit buildDateTimeChanged(m_buildDateTime);
}

void AppInfo::setBuildRevision(const QString &buildRevision)
{
    if (m_buildRevision == buildRevision)
        return;

    m_buildRevision = buildRevision;
    emit buildRevisionChanged(m_buildRevision);
}

void AppInfo::setCopyRight(const QString &copyRight)
{
    if (m_copyRight == copyRight)
        return;

    m_copyRight = copyRight;
    emit copyRightChanged(m_copyRight);
}

void AppInfo::setDescript(const QString &descript)
{
    if (m_descript == descript)
        return;

    m_descript = descript;
    emit descriptChanged(m_descript);
}

void AppInfo::setCompilerVendor(const QString &compilerVendor)
{
    if (m_compilerVendor == compilerVendor)
        return;

    m_compilerVendor = compilerVendor;
    emit compilerVendorChanged(m_compilerVendor);
}

void AppInfo::setSplashShow(bool splashShow)
{
    if (m_splashShow == splashShow)
        return;

    m_splashShow = splashShow;
    emit splashShowChanged(m_splashShow);
}
