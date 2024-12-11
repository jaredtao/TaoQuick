
#include "AppInfo.h"
#include "DeviceAddTable/DeviceAddModel.h"
#include "Frameless/TaoFrameLessView.h"

#ifndef TAODEBUG
#include "Logger/Logger.h"
#endif

#include "QuickTool/QuickTool.h"
#include "Trans/Trans.h"
#include <QDir>
#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlEngine>
#include <QQuickItem>
#include <QUrl>

static void prepareApp()
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
	QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	QGuiApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);
#if (QT_VERSION >= QT_VERSION_CHECK(5, 14, 0))
	QGuiApplication::setHighDpiScaleFactorRoundingPolicy(Qt::HighDpiScaleFactorRoundingPolicy::PassThrough);
#endif
#endif
	QCoreApplication::setOrganizationName("JaredTao");
	QCoreApplication::setOrganizationDomain("https://jaredtao.github.io");
	QCoreApplication::setApplicationName("TaoQuickShow");
}

int main(int argc, char** argv)
{
	prepareApp();
	QGuiApplication app(argc, argv);
#ifdef TAODEBUG
	//    qSetMessagePattern("[%{time h:mm:ss.zzz} %{function}] %{message}");
	qSetMessagePattern("[%{time h:mm:ss.zzz} %{file} row(%{line}) %{function}] %{message}");
#else
	Logger::initLog();
#endif
	const auto appPath = QDir::cleanPath(app.applicationDirPath());
	qWarning() << "appPath" << appPath;

	QString taoQuickShowPath = TaoQuickShowPath;
	QString transDir		 = taoQuickShowPath + "Trans/";
	if (transDir.startsWith("file:///"))
	{
		transDir = transDir.remove("file:///");
	}
	if (transDir.startsWith("qrc:/"))
	{
		transDir = transDir.remove("qrc");
	}
	QString qmlPath		 = taoQuickShowPath + "Qml/";
	QString imgPath		 = taoQuickShowPath + "Image/";
	QString contentsPath = taoQuickShowPath + "Contents/";
	qWarning() << "qmlPath" << qmlPath;
	qWarning() << "imgPath" << imgPath;
	qWarning() << "contentsPath" << contentsPath;
	Trans	  trans;
	AppInfo	  appInfo;
	QuickTool quickTool;

	TaoFrameLessView rootView;
	rootView.setMinimumSize({ 800, 600 });
	rootView.resize(1440, 960);
	trans.beforeUiReady(rootView.rootContext(), transDir);
	appInfo.beforeUiReady(rootView.rootContext());

	rootView.engine()->addImportPath(qmlPath);
#ifdef TaoQuickImportPath
	rootView.engine()->addImportPath(TaoQuickImportPath);
	rootView.rootContext()->setContextProperty("taoQuickImportPath", TaoQuickImportPath);
	qWarning() << "TaoQuickImportPath " << TaoQuickImportPath;
#endif

#ifdef TAODEBUG
	rootView.rootContext()->setContextProperty("isDebug", true);
#else
	rootView.rootContext()->setContextProperty("isDebug", QVariant(false));
#endif

#if QT_VERSION > QT_VERSION_CHECK(5, 10, 0)
	rootView.rootContext()->setContextProperty("hasShape", true);
#else
	rootView.rootContext()->setContextProperty("hasShape", false);
#endif

#if QT_VERSION > QT_VERSION_CHECK(5, 14, 0)
	rootView.rootContext()->setContextProperty("comboBoxHasValueRole", true);
#else
	rootView.rootContext()->setContextProperty("comboBoxHasValueRole", false);
#endif

#if QT_VERSION > QT_VERSION_CHECK(5, 11, 0)
	rootView.rootContext()->setContextProperty("scrollBarHasMinimumSize", true);
#else
	rootView.rootContext()->setContextProperty("scrollBarHasMinimumSize", false);
#endif

	rootView.rootContext()->setContextProperty("appPath", appPath);
	rootView.rootContext()->setContextProperty("qmlPath", qmlPath);
	rootView.rootContext()->setContextProperty("imgPath", imgPath);
	rootView.rootContext()->setContextProperty("contentsPath", contentsPath);
	rootView.rootContext()->setContextProperty("rootView", &rootView);
	rootView.rootContext()->setContextProperty("quickTool", &quickTool);

	DeviceAddModel model;

	rootView.rootContext()->setContextProperty("deviceAddModel", &model);
	const QUrl url(qmlPath + QStringLiteral("main.qml"));
	QObject::connect(
		&rootView,
		&QQuickView::statusChanged,
		&rootView,
		[&](QQuickView::Status status)
		{
			if (status == QQuickView::Status::Ready)
			{
				trans.afterUiReady();
				appInfo.afterUiReady();
				quickTool.setRootObjet(rootView.rootObject());
			}
		});
	// qml call 'Qt.quit()' will emit engine::quit, here should call qApp->quit
	QObject::connect(rootView.engine(), &QQmlEngine::quit, qApp, &QCoreApplication::quit);
	// qml clear content before quit
	QObject::connect(
		qApp,
		&QGuiApplication::aboutToQuit,
		qApp,
		[&rootView]()
		{
			rootView.setSource({});
			qInstallMessageHandler(nullptr);
		});

	rootView.setSource(url);
	rootView.moveToScreenCenter();
	rootView.show();

	return app.exec();
}
