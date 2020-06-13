#include "TaoView.h"
#ifdef VER_Utf16
#include "Ver-u16.h"
#else
#include "Ver-u8.h"
#endif
#include <QQmlContext>
#include <QQmlEngine>
#include <QQuickItem>
#include <QGuiApplication>
#include <QScreen>
TaoView::TaoView(QWindow *parent) : QQuickView(parent)
{
    setFlag(Qt::FramelessWindowHint);
    setResizeMode(SizeRootObjectToView);
    setColor(QColor(Qt::transparent));

}

TaoView::~TaoView()
{
}

void TaoView::initAppInfo()
{
    auto pInfo = rootObject()->findChild<QObject * >("appInfo");
    if (pInfo)
    {
        pInfo->setProperty("appName", VER_PRODUCTNAME_STR);
        pInfo->setProperty("appVersion", TaoVer);
        pInfo->setProperty("latestVersion", TaoVer);
        pInfo->setProperty("buildDateTime", TaoDATETIME);
        pInfo->setProperty("buildRevision", TaoREVISIONSTR);
        pInfo->setProperty("copyRight", VER_LEGALCOPYRIGHT_STR);
        pInfo->setProperty("descript", QString::fromLocal8Bit(VER_FILEDESCRIPTION_STR));
        pInfo->setProperty("compilerVendor", TaoCompilerVendor);
    }
}

void TaoView::moveToScreenCenter()
{
    auto screenGeo = qApp->primaryScreen()->geometry();
    auto viewGeo = geometry();
    QPoint centerPos = {(screenGeo.width() - viewGeo.width()) / 2, (screenGeo.height() - viewGeo.height()) /2 };
    setPosition(centerPos);
}
