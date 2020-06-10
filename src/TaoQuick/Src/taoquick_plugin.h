#pragma once
#include <QtGlobal>
#include <QDebug>

#if QT_VERSION >= QT_VERSION_CHECK(5, 15, 0)
#include <QQmlEngineExtensionPlugin>

class TaoQuickPlugin : public QQmlEngineExtensionPlugin

{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlEngineExtensionInterface_iid)
public:
    void initializeEngine(QQmlEngine* engine, const char* uri) override
    {
        Q_INIT_RESOURCE(Qml);
        qInfo() << "\033[35m"
                << "Your application is using TaoQuick ";
        qInfo() << " Version:" << TaoVer;
        qInfo() << " Revision:" << TaoREVISIONSTR;
        qInfo() << " Author: Jared Tao";
        qInfo() << " You can find more info about TaoQuick in website:"
                << "\033[0m"
                << "\033[31m"
                << "https://github.com/jaredtao";

        qInfo() << "\033[0m\033[32m"
                << "Good luck to you."
                << "\033[0m";
        QQmlEngineExtensionPlugin::initializeEngine(engine, uri);
    }
};

#else
#include <QQmlExtensionPlugin>

class TaoQuickPlugin : public QQmlExtensionPlugin {
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)
public:
    void registerTypes(const char* uri) override
    {
        Q_INIT_RESOURCE(Qml);
        qInfo() << "\033[35m"
                << "Your application is using TaoQuick ";
        qInfo() << " Version:" << TaoVer;
        qInfo() << " Revision:" << TaoREVISIONSTR;
        qInfo() << " Author: Jared Tao";
        qInfo() << " You can find more info about TaoQuick in website:"
                << "\033[0m"
                << "\033[31m"
                << "https://github.com/jaredtao";

        qInfo() << "\033[0m\033[32m"
                << "Good luck to you."
                << "\033[0m";
    }
};

#endif
