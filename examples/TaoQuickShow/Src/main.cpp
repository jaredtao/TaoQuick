#include "AppInfo.h"
#include "Trans/Trans.h"
#include "Frameless/TaoFrameLessView.h"
#include "logger.h"
#include "DeviceAdd/DeviceAddModel.h"
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
    QCoreApplication::setApplicationName("TaoQuickShow");
}

int main(int argc, char **argv)
{
    prepareApp();
    QGuiApplication app(argc, argv);
#ifdef TAODEBUG
    qSetMessagePattern("[%{time h:mm:ss.zzz} %{function}] %{message}");
//    qSetMessagePattern("[%{time h:mm:ss.zzz} %{file} row(%{line}) %{function}] %{message}");
#else
    Logger::initLog();
#endif
    const auto appPath = QDir::cleanPath(app.applicationDirPath());
    qWarning() << "appPath" << appPath;

    TaoFrameLessView view;
    view.setMinimumSize({ 800, 600 });
    view.resize(1440, 960);
    view.moveToScreenCenter();
    Trans trans;
    AppInfo appInfo;
    trans.beforeUiReady(view.rootContext());
    appInfo.beforeUiReady(view.rootContext());

    view.engine()->addImportPath(qmlPath);
#ifdef TaoQuickImportPath
    view.engine()->addImportPath(TaoQuickImportPath);
    qWarning() << "TaoQuickImportPath " << TaoQuickImportPath;
#endif

#ifdef TaoQuickImagePath
    view.rootContext()->setContextProperty("taoQuickImagePath", TaoQuickImagePath);
#endif

#ifdef TAODEBUG
    view.rootContext()->setContextProperty("isDebug", true);
#else
    view.rootContext()->setContextProperty("isDebug", false);
#endif

    view.rootContext()->setContextProperty("qmlPath", qmlPath);
    view.rootContext()->setContextProperty("imgPath", imgPath);
    view.rootContext()->setContextProperty("contentsPath", contentsPath);
    view.rootContext()->setContextProperty("appPath", appPath);
    view.rootContext()->setContextProperty("view", &view);

    DeviceAddModel model;

     view.rootContext()->setContextProperty("deviceAddModel", &model);
    const QUrl url(qmlPath + QStringLiteral("main.qml"));
    QObject::connect(&view, &QQuickView::statusChanged, [&](QQuickView::Status status) {
        if (status == QQuickView::Status::Ready) {
            trans.afterUiReady();
            appInfo.afterUiReady();
        }
    });
    QObject::connect(view.engine(), &QQmlEngine::quit, qApp, &QCoreApplication::quit);
    view.setSource(url);
    view.moveToScreenCenter();
    view.show();

    return app.exec();
}
