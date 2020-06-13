#pragma once
#include "ITaoQuickPlugin.h"
#include <QObject>
#include <memory>
#include <QPluginLoader>

class PluginLoader : public QObject{
    Q_OBJECT
public:
    PluginLoader(QObject *parent = nullptr);
    ~PluginLoader() override;

    Q_INVOKABLE void loadPlugin(const QString &pluginPath = u8"plugin/");

signals:
    void pluginReady(QString pluginInfo);
private:
    QList<ITaoQuickPlugin *> m_pluginList;
    std::unique_ptr<QPluginLoader> m_loader = nullptr;
};
