#include "ComponentsManager.h"
#include <QDebug>
#include <QDir>
#include <QQmlContext>
#include <QUrl>
ComponentsMgr::ComponentsMgr(QObject* parent)
    : QObject(parent)
{
}

void ComponentsMgr::loadFolder(const QString& folder)
{
    QString dirPath;
    qWarning() << "folder" << folder;
#ifdef TAODEBUG
    dirPath = QUrl(folder).toLocalFile();
#else
    //'qrc:/xxx' remove 'qrc' leave ':/xxx'
    dirPath = QString(folder).remove(0, 3);
#endif
    qWarning() << "dirPath" << dirPath;
    QDir d(dirPath);
    QJsonArray modules;
    auto infos = d.entryInfoList(QDir::Dirs | QDir::NoDotAndDotDot);
    for (auto info : infos) {
        QJsonObject module;
        module["name"] = info.fileName();
        QDir subDir(info.absoluteFilePath());
        auto subInfos = subDir.entryInfoList(QStringList { "*.qml" }, QDir::Files | QDir::NoDotAndDotDot);
        QStringList comps;
        QStringList compNames;
        for (auto subInfo : subInfos) {
#ifdef TAODEBUG
            comps.push_back(QUrl::fromLocalFile(subInfo.absoluteFilePath()).toString());
#else
            comps.push_back("qrc" + subInfo.absoluteFilePath());
#endif
            qWarning() << "comp" << comps.back();
            compNames.push_back(subInfo.fileName());
        }
        module["comps"] = QJsonArray::fromStringList(comps);
        module["compNames"] = QJsonArray::fromStringList(compNames);
        module["count"] = comps.length();
        auto iconInfos = subDir.entryInfoList(QStringList { "icon.png", "icon.jpg", "icon. jpeg", "icon.bmp", "icon.gif", "icon.webp" }, QDir::Files | QDir::NoDotAndDotDot);
        module["icon"] = iconInfos.empty() ? "" : QUrl::fromLocalFile(iconInfos.first().absoluteFilePath()).toString();
        modules.append(module);
    }
    setComps(modules);
}

void ComponentsMgr::init()
{
}

void ComponentsMgr::uninit()
{
}

void ComponentsMgr::beforeUiReady(QQmlContext* ctx)
{
    ctx->setContextProperty("componentsMgr", this);
}

void ComponentsMgr::afterUiReady()
{
    loadFolder(contentsPath);
}

const QJsonArray& ComponentsMgr::comps() const
{
    return m_comps;
}

void ComponentsMgr::setComps(const QJsonArray& comps)
{
    if (m_comps == comps)
        return;

    m_comps = comps;
    emit compsChanged(m_comps);
}
