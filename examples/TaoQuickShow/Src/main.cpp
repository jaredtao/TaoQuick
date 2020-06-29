#include "TaoView.h"
#include "logger.h"
#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlEngine>
#include "Trans.h"
#include "PluginLoader.h"

int main(int argc, char **argv)
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("JaredTao");
    app.setOrganizationDomain("https://jaredtao.github.io");
    Logger::initLog();
    Trans trans;
    trans.loadFolder(app.applicationDirPath() + "/Trans");
    PluginLoader loader;
    TaoView view;

    view.rootContext()->setContextProperty("view", &view);
    view.rootContext()->setContextProperty("trans", &trans);
    view.rootContext()->setContextProperty("pluginLoader", &loader);

    view.setSource(QUrl(QStringLiteral("qrc:/Qml/main.qml")));
    view.moveToScreenCenter();
    view.show();

    return app.exec();
}
