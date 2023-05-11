#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlEngine>
#include <QQuickView>
int main(int argc, char** argv)
{
	QGuiApplication app(argc, argv);
	QQuickView		view;
	view.engine()->addImportPath(TaoQuickImportPath);
	view.rootContext()->setContextProperty("taoQuickImportPath", TaoQuickImportPath);

	view.setSource(QUrl("qrc:/main.qml"));
	view.show();

	return app.exec();
}