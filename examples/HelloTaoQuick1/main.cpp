#include <QQuickView>
#include <QQmlEngine>
#include <QQmlContext>
#include <QGuiApplication>
int main(int argc, char **argv)
{
    QGuiApplication app(argc, argv);
    QQuickView view;
    view.engine()->addImportPath(TaoQuickImportPath);
    view.rootContext()->setContextProperty("taoQuickImagePath", TaoQuickImagePath);

    view.setSource(QUrl("qrc:/main.qml"));
    view.show();
    
    return app.exec();
}