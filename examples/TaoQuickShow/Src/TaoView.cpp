#include "TaoView.h"

#include "Ver-u8.h"

#include <QCursor>
#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlEngine>
#include <QQuickItem>

#if WIN32

#include <WinUser.h>
#include <dwmapi.h>
#include <objidl.h> // Fixes error C2504: 'IUnknown' : base class undefined
#include <windows.h>
#include <windowsx.h>
#pragma comment(lib, "Dwmapi.lib") // Adds missing library, fixes error LNK2019: unresolved external symbol __imp__DwmExtendFrameIntoClientArea
#pragma comment(lib, "user32.lib")

#endif

const LONG border_width = 6;

TaoView::TaoView(QWindow* parent)
    : QQuickView(parent)
{
    setFlags(Qt::Window | Qt::FramelessWindowHint | Qt::WindowSystemMenuHint | Qt::WindowMinMaxButtonsHint);
    setResizeMode(SizeRootObjectToView);
    setColor(QColor(Qt::transparent));
    resize(1440, 960);
#if WIN32
    DWORD style = ::GetWindowLong(HWND(winId()), GWL_STYLE);
    style |= WS_MINIMIZEBOX | WS_THICKFRAME | WS_CAPTION;
    ::SetWindowLong(HWND(winId()), GWL_STYLE, style);

#endif
    setIsMax(windowState() == Qt::WindowMaximized);
    connect(this, &QWindow::windowStateChanged, this, [&](Qt::WindowState state){
        setIsMax(state == Qt::WindowMaximized);
    });
}

TaoView::~TaoView()
{
}

void TaoView::initAppInfo()
{
    auto pInfo = rootObject()->findChild<QObject*>("appInfo");
    if (pInfo) {
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
    QPoint centerPos = { (screenGeo.width() - viewGeo.width()) / 2, (screenGeo.height() - viewGeo.height()) / 2 };
    setPosition(centerPos);
}

void TaoView::setIsMax(bool isMax)
{
    if (m_isMax == isMax)
        return;

    m_isMax = isMax;
    emit isMaxChanged(m_isMax);
}

#if WIN32
bool TaoView::nativeEvent(const QByteArray& eventType, void* message, long* result)
{
#if (QT_VERSION == QT_VERSION_CHECK(5, 11, 1))
    MSG* msg = *reinterpret_cast<MSG**>(message);
#else
    MSG* msg = reinterpret_cast<MSG*>(message);
#endif
    switch (msg->message) {
    case WM_NCCALCSIZE: {
        NCCALCSIZE_PARAMS& params = *reinterpret_cast<NCCALCSIZE_PARAMS*>(msg->lParam);
        if (!(windowStates() & Qt::WindowFullScreen) && !(windowStates() & Qt::WindowMaximized)) {
            if (params.rgrc[0].top != 0)
                params.rgrc[0].top -= 1;
        }
        //this kills the window frame and title bar we added with WS_THICKFRAME and WS_CAPTION
        *result = WVR_REDRAW;
        return true;
    }
    case WM_NCHITTEST: {
        *result = 0;

        RECT winrect;
        GetWindowRect(HWND(winId()), &winrect);

        long x = GET_X_LPARAM(msg->lParam);
        long y = GET_Y_LPARAM(msg->lParam);

        bool resizeWidth = minimumWidth() != maximumWidth();
        bool resizeHeight = minimumHeight() != maximumHeight();

        if (resizeWidth) {
            //left border
            if (x >= winrect.left && x < winrect.left + border_width) {
                *result = HTLEFT;
            }
            //right border
            if (x < winrect.right && x >= winrect.right - border_width) {
                *result = HTRIGHT;
            }
        }
        if (resizeHeight) {
            //bottom border
            if (y < winrect.bottom && y >= winrect.bottom - border_width) {
                *result = HTBOTTOM;
            }
            //top border
            if (y >= winrect.top && y < winrect.top + border_width) {
                *result = HTTOP;
            }
        }
        if (resizeWidth && resizeHeight) {
            //bottom left corner
            if (x >= winrect.left && x < winrect.left + border_width && y < winrect.bottom && y >= winrect.bottom - border_width) {
                *result = HTBOTTOMLEFT;
            }
            //bottom right corner
            if (x < winrect.right && x >= winrect.right - border_width && y < winrect.bottom && y >= winrect.bottom - border_width) {
                *result = HTBOTTOMRIGHT;
            }
            //top left corner
            if (x >= winrect.left && x < winrect.left + border_width && y >= winrect.top && y < winrect.top + border_width) {
                *result = HTTOPLEFT;
            }
            //top right corner
            if (x < winrect.right && x >= winrect.right - border_width && y >= winrect.top && y < winrect.top + border_width) {
                *result = HTTOPRIGHT;
            }
        }
        if (0 != *result) {
            return true;
        }
        double dpr = qApp->devicePixelRatio();
        QPoint pos = mapFromGlobal(QPoint(x/dpr,y/dpr));
        QRect titleRect(border_width, border_width, width() * 0.8, 40);
        if (titleRect.contains(pos))
        {
            *result = HTCAPTION;
            return true;
        }
        return false;
    } //end case WM_NCHITTEST
    }
    return QQuickView::nativeEvent(eventType, message, result);
}
#endif
