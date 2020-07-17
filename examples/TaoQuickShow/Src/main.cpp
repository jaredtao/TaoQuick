#include "TaoView.h"

#include "AppInfo.h"
#include "ComponentsManager.h"
#include "TaoFramework.h"
#include "Trans.h"
#include "logger.h"
#include <QDir>
#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlEngine>
#include <QUrl>
static void prepareApp()
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setOrganizationName("JaredTao");
    QCoreApplication::setOrganizationDomain("https://JaredTao.gitee.io");
    QCoreApplication::setApplicationName("TaoQuickApp");
}

int main(int argc, char** argv)
{
    prepareApp();
    QGuiApplication app(argc, argv);
    qWarning() << "appPath" << app.applicationDirPath();
    Logger::initLog();

    TaoView view;

    TaoFramework::instance()->setMainView(&view);
    TaoFramework::instance()->createObject<Trans>();
    TaoFramework::instance()->createObject<AppInfo>();
    TaoFramework::instance()->createObject<ComponentsMgr>();

    TaoFramework::instance()->init();
    TaoFramework::instance()->beforeUiReady(view.rootContext());

    view.engine()->addImportPath(qmlPath);
    view.rootContext()->setContextProperty("qmlPath", qmlPath);
    view.rootContext()->setContextProperty("imgPath", imgPath);
    view.rootContext()->setContextProperty("contentsPath", contentsPath);
    view.rootContext()->setContextProperty("appPath", app.applicationDirPath());
    view.rootContext()->setContextProperty("view", &view);

    const QUrl url(qmlPath + QStringLiteral("main.qml"));
    QObject::connect(&view, &QQuickView::statusChanged, [=](QQuickView::Status status) {
        if (status == QQuickView::Status::Ready) {
            TaoFramework::instance()->afterUiReady();
        }
    });
    view.setSource(url);
    view.moveToScreenCenter();
    view.show();

    return app.exec();
}
