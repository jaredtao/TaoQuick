#include "TaoView.h"
#include "Logger/Logger.h"
#ifdef VER_Utf16
#include "Ver-u16.h"
#else
#include "Ver-u8.h"
#endif

#include <QTranslator>
#include <QQmlEngine>
#include <QGuiApplication>
#include <QDir>
#include <QJsonDocument>
#include <QQuickItem>
#include <QScreen>
TaoView::TaoView(QWindow *parent) : QQuickView(parent)
{
    setFlag(Qt::FramelessWindowHint);
    setResizeMode(SizeRootObjectToView);
    setColor(QColor(Qt::transparent));

}

TaoView::~TaoView()
{
    qDeleteAll(m_pluginList);
    m_pluginList.clear();
}


void TaoView::loadPlugin(const QString &pluginPath)
{
    QDir dir(qApp->applicationDirPath() + "/" + pluginPath);

    auto list = dir.entryInfoList({"*"}, QDir::Files);

    for (auto info : list) {
        if (QLibrary::isLibrary(info.absoluteFilePath()))
        {
            m_loader = std::make_unique<QPluginLoader>();
            m_loader->setFileName(info.absoluteFilePath());
            if (!m_loader->load())
            {
                LOG_WARN << m_loader->fileName() << m_loader->errorString();
                continue;
            }
            QObject *pObj = m_loader->instance();
            auto pPlugin = qobject_cast<ITaoQuickPlugin *>(pObj);
            if (!pPlugin)
            {
                continue;
            }
            pPlugin->init();
            emit pluginReady(QString(QJsonDocument(pPlugin->infos()).toJson()));
            m_pluginList.append(pPlugin);
            LOG_INFO << "loaded plugin " << info.absoluteFilePath();
        }
    }
}

void TaoView::initAppInfo()
{
    auto pInfo = rootObject()->findChild<QObject * >("appInfo");
    if (pInfo)
    {
        pInfo->setProperty("appName", VER_PRODUCTNAME_STR);
        pInfo->setProperty("appVersion", TaoVer);
        pInfo->setProperty("latestVersion", TaoVer);
        pInfo->setProperty("buildDateTime", TaoDATETIME);
        pInfo->setProperty("buildRevision", TaoREVISIONSTR);
        pInfo->setProperty("copyRight", VER_LEGALCOPYRIGHT_STR);
        pInfo->setProperty("descript", QString::fromLocal8Bit(VER_FILEDESCRIPTION_STR));
        pInfo->setProperty("compilerVendor", TaoCompilerVendor);
    }
}

void TaoView::moveToScreenCenter()
{
    auto screenGeo = qApp->primaryScreen()->geometry();
    auto viewGeo = geometry();
    QPoint centerPos = {(screenGeo.width() - viewGeo.width()) / 2, (screenGeo.height() - viewGeo.height()) /2 };
    setPosition(centerPos);
}
