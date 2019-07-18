#include "TaoView.h"
#include "Logger/Logger.h"

#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlEngine>
#include <QGradient>
#include <QDebug>

int main(int argc, char **argv)
{
    QGuiApplication app(argc, argv);
    app.setOrganizationName("JaredTao");
    app.setOrganizationDomain("https://jaredtao.github.io");
    Logger::initLog();

    QSurfaceFormat fmt = QSurfaceFormat::defaultFormat();
    qDebug() << fmt.version();
    fmt.setSamples(4);
    QSurfaceFormat::setDefaultFormat(fmt);
    TaoView view;
    view.rootContext()->setContextProperty("view", &view);
    view.setSource(QUrl(QStringLiteral("qrc:/Qml/main.qml")));
    view.show();

    return app.exec();
}
