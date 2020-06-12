#pragma once

#include "ITaoQuickPlugin.h"

#include <QQuickView>
#include <memory>
#include <QPluginLoader>
class QTranslator;

class TaoView : public QQuickView
{
    Q_OBJECT
public:
    explicit TaoView(QWindow *parent = nullptr);
    ~TaoView();
    Q_INVOKABLE void loadPlugin(const QString &pluginPath = u8"plugin/");
    Q_INVOKABLE void initAppInfo();

    void moveToScreenCenter();

signals:
    void pluginReady(QString pluginInfo);
public slots:
private:
    QList<ITaoQuickPlugin *> m_pluginList;
    std::unique_ptr<QPluginLoader> m_loader = nullptr;
};

