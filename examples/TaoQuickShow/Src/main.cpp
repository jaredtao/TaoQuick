#include "TaoView.h"
#include "Trans.h"
#include "logger.h"
#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlEngine>
#include <QUrl>
#include <QDir>
static void prepareApp()
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setOrganizationName("JaredTao");
    QCoreApplication::setOrganizationDomain("https://JaredTao.gitee.io");
    QCoreApplication::setApplicationName("TaoQuickApp");
}
static void beforeUiReady(QQmlContext *ctx)
{
    Q_UNUSED(ctx)
}
static void afterUiReady()
{

}
int main(int argc, char** argv)
{
    prepareApp();
    QGuiApplication app(argc, argv);

    Logger::initLog();
    Trans trans;

    TaoView view;

    beforeUiReady(view.rootContext());
    view.engine()->addImportPath(qmlPath);
    view.rootContext()->setContextProperty("qmlPath", qmlPath);
    view.rootContext()->setContextProperty("imgPath", imgPath);
    view.rootContext()->setContextProperty("appPath", app.applicationDirPath());
    view.rootContext()->setContextProperty("view", &view);
    view.rootContext()->setContextProperty("trans", &trans);

    const QUrl url(qmlPath + QStringLiteral("main.qml"));
    QObject::connect(&view, &QQuickView::statusChanged, [=](QQuickView::Status status){
        if (status == QQuickView::Status::Ready) {
            afterUiReady();
        }
    });
    view.setSource(url);
    view.moveToScreenCenter();
    view.show();

    return app.exec();
}
