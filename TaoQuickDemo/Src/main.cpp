#include "TaoView.h"
#include "Logger/Logger.h"

#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlEngine>
#include <QGradient>
#include <QDebug>
#include <QScreen>
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
    //View center in screen
    auto screenGeo = app.primaryScreen()->geometry();
    auto viewGeo = view.geometry();
    QPoint centerPos = {(screenGeo.width() - viewGeo.width()) / 2, (screenGeo.height() - viewGeo.height()) /2 };
    view.setPosition(centerPos);
    view.show();

    return app.exec();
}
