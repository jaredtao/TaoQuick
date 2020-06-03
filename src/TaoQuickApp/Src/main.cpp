#include "TaoView.h"
#include "Logger/Logger.h"

#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlEngine>

int main(int argc, char **argv)
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("JaredTao");
    app.setOrganizationDomain("https://jaredtao.github.io");
    Logger::initLog();

    TaoView view;
    view.engine()->addImportPath(app.applicationDirPath());
    view.engine()->addPluginPath(app.applicationDirPath());
    view.rootContext()->setContextProperty("view", &view);
    view.setSource(QUrl(QStringLiteral("qrc:/Qml/main.qml")));
    view.moveToScreenCenter();
    view.show();

    return app.exec();
}
