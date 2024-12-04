#include "AppInfo.h"
#include "DeviceAddTable/DeviceAddModel.h"
#include "Frameless/TaoFrameLessView.h"

#	include "Logger/Logger.h"

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
#	if (QT_VERSION >= QT_VERSION_CHECK(5, 14, 0))
	QGuiApplication::setHighDpiScaleFactorRoundingPolicy(Qt::HighDpiScaleFactorRoundingPolicy::PassThrough);
#	endif
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
	Logger::initDebugMessageFormat();
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

	TaoFrameLessView view;
	view.setMinimumSize({ 800, 600 });
	view.resize(1440, 960);
	trans.beforeUiReady(view.rootContext(), transDir);
	appInfo.beforeUiReady(view.rootContext());

	view.engine()->addImportPath(qmlPath);
#ifdef TaoQuickImportPath
	view.engine()->addImportPath(TaoQuickImportPath);
	view.rootContext()->setContextProperty("taoQuickImportPath", TaoQuickImportPath);
	qWarning() << "TaoQuickImportPath " << TaoQuickImportPath;
#endif

#ifdef TAODEBUG
	view.rootContext()->setContextProperty("isDebug", true);
#else
	view.rootContext()->setContextProperty("isDebug", QVariant(false));
#endif

#if QT_VERSION > QT_VERSION_CHECK(5, 10, 0)
	view.rootContext()->setContextProperty("hasShape", true);
#else
	view.rootContext()->setContextProperty("hasShape", false);
#endif

#if QT_VERSION > QT_VERSION_CHECK(5, 14, 0)
	view.rootContext()->setContextProperty("comboBoxHasValueRole", true);
#else
	view.rootContext()->setContextProperty("comboBoxHasValueRole", false);
#endif

#if QT_VERSION > QT_VERSION_CHECK(5, 11, 0)
	view.rootContext()->setContextProperty("scrollBarHasMinimumSize", true);
#else
	view.rootContext()->setContextProperty("scrollBarHasMinimumSize", false);
#endif

	view.rootContext()->setContextProperty("appPath", appPath);
	view.rootContext()->setContextProperty("qmlPath", qmlPath);
	view.rootContext()->setContextProperty("imgPath", imgPath);
	view.rootContext()->setContextProperty("contentsPath", contentsPath);
	view.rootContext()->setContextProperty("view", &view);
	view.rootContext()->setContextProperty("quickTool", &quickTool);

	DeviceAddModel model;

	view.rootContext()->setContextProperty("deviceAddModel", &model);
	const QUrl url(qmlPath + QStringLiteral("main.qml"));
	QObject::connect(
		&view,
		&QQuickView::statusChanged,
		&view,
		[&](QQuickView::Status status)
		{
			if (status == QQuickView::Status::Ready)
			{
				trans.afterUiReady();
				appInfo.afterUiReady();
				quickTool.setRootObjet(view.rootObject());
			}
		});
	// qml call 'Qt.quit()' will emit engine::quit, here should call qApp->quit
	QObject::connect(view.engine(), &QQmlEngine::quit, qApp, &QCoreApplication::quit);
	// qml clear content before quit
	QObject::connect(qApp, &QGuiApplication::aboutToQuit, qApp, [&view]() { view.setSource({}); });

	view.setSource(url);
	view.moveToScreenCenter();
	view.show();

	return app.exec();
}
