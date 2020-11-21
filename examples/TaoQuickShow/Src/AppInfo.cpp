#include "AppInfo.h"
#include <QQmlContext>
#include <QSysInfo>
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
    m_compilerVendor = QString("%1(%2 %3)").arg(QT_VERSION_STR).arg(CXX_COMPILER_ID).arg(QSysInfo::buildCpuArchitecture());
}

void AppInfo::beforeUiReady(QQmlContext *ctx)
{
    ctx->setContextProperty("appInfo", this);
}

void AppInfo::afterUiReady()
{

//    auto json = QJsonDocument(*this).toJson(QJsonDocument::Indented);
//    json.replace("\\n\\r","\\\n");
//    qWarning() << json;

}


AppInfo::~AppInfo()
{

}
