#include "PluginLoader.h"
#include "Logger/Logger.h"
#include <QDir>
#include <QCoreApplication>
#include <QJsonDocument>
PluginLoader::PluginLoader(QObject *parent) : QObject(parent)
{

}

PluginLoader::~PluginLoader()
{
    qDeleteAll(m_pluginList);
    m_pluginList.clear();
}

void PluginLoader::loadPlugin(const QString &pluginPath)
{
    QDir dir(qApp->applicationDirPath() + "/" + pluginPath);

    auto list = dir.entryInfoList(QDir::Files);

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
