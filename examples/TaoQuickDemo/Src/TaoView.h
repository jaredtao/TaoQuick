#pragma once

#include "ITaoQuickPlugin.h"

#include <QQuickView>
#include <memory>
#include <QPluginLoader>
class QTranslator;

class TaoView : public QQuickView
{
    Q_OBJECT
    Q_PROPERTY(QStringList languageList READ languageList NOTIFY languageListChanged)
public:
    explicit TaoView(QWindow *parent = nullptr);
    ~TaoView();
    Q_INVOKABLE void reTrans(const QString &lang);
    Q_INVOKABLE void loadPlugin(const QString &pluginPath = u8"plugin/");
    Q_INVOKABLE void initAppInfo();

    void moveToScreenCenter();

    const QStringList &languageList() const
    {
        return m_languageList;
    }
signals:
    void reTransed();
    void languageListChanged();
    void pluginReady(QString pluginInfo);
public slots:
private:
    QString m_lang;
    QMap<QString, std::shared_ptr<QTranslator>> m_transMap;
    QTranslator *m_pLastLang;
    QStringList m_languageList;
    QList<ITaoQuickPlugin *> m_pluginList;
    std::unique_ptr<QPluginLoader> m_loader = nullptr;
};

