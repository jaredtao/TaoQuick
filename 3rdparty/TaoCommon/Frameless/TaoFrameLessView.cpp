#include "TaoFrameLessView.h"

#include <QGuiApplication>
#include <QQuickItem>
#include <QScreen>
#include <QWindow>
#if WIN32

#include <WinUser.h>
#include <dwmapi.h>
#include <objidl.h> // Fixes error C2504: 'IUnknown' : base class undefined
#include <windows.h>
#include <windowsx.h>
#pragma comment(lib, "Dwmapi.lib") // Adds missing library, fixes error LNK2019: unresolved external symbol __imp__DwmExtendFrameIntoClientArea
#pragma comment(lib, "user32.lib")

#endif

#ifdef WIN32
static long hitTest(RECT winrect, long x, long y, int borderWidth)
{
    // 鼠标区域位于窗体边框，进行缩放
    if ((x >= winrect.left) && (x < winrect.left + borderWidth) && (y >= winrect.top) && (y < winrect.top + borderWidth)) {
        return HTTOPLEFT;
    } else if (x < winrect.right && x >= winrect.right - borderWidth && y >= winrect.top && y < winrect.top + borderWidth) {
        return HTTOPRIGHT;
    } else if (x >= winrect.left && x < winrect.left + borderWidth && y < winrect.bottom && y >= winrect.bottom - borderWidth) {
        return HTBOTTOMLEFT;
    } else if (x < winrect.right && x >= winrect.right - borderWidth && y < winrect.bottom && y >= winrect.bottom - borderWidth) {
        return HTBOTTOMRIGHT;
    } else if (x >= winrect.left && x < winrect.left + borderWidth) {
        return HTLEFT;
    } else if (x < winrect.right && x >= winrect.right - borderWidth) {
        return HTRIGHT;
    } else if (y >= winrect.top && y < winrect.top + borderWidth) {
        return HTTOP;
    } else if (y < winrect.bottom && y >= winrect.bottom - borderWidth) {
        return HTBOTTOM;
    } else {
        return 0;
    }
}
#endif

static bool isMaxWin(QWindow *win)
{
    return win->windowState() == Qt::WindowMaximized;
}
static bool isFullWin(QQuickView *win)
{
    return win->windowState() == Qt::WindowFullScreen;
}

TaoFrameLessView::TaoFrameLessView(QWindow *parent)
    : QQuickView(parent)
{
    setFlags(/*Qt::CustomizeWindowHint | */Qt::Window | Qt::FramelessWindowHint | Qt::WindowMinMaxButtonsHint | Qt::WindowTitleHint | Qt::WindowSystemMenuHint);
    setResizeMode(SizeViewToRootObject);
    setColor(QColor(Qt::transparent));
    setMinimumSize({1024, 720});
    resize(1440, 960);

    //WS_THICKFRAME 带回Areo效果
#if WIN32
    DWORD style = ::GetWindowLong(HWND(winId()), GWL_STYLE);
    style |= WS_THICKFRAME;
    ::SetWindowLong(HWND(winId()), GWL_STYLE, style);
#endif

    setIsMax(isMaxWin(this));
    connect(this, &QWindow::windowStateChanged, this, [&](Qt::WindowState state) { setIsMax(state == Qt::WindowMaximized); });
}

TaoFrameLessView::~TaoFrameLessView() {}
void TaoFrameLessView::setTitleItem(QQuickItem *item)
{
    m_titleItem = item;
}
void TaoFrameLessView::moveToScreenCenter()
{
    auto geo = screen()->availableGeometry();
    int  w = width();
    int  h = height();
    auto pos = QPoint{ geo.x() + (geo.width() - w) / 2, geo.y() + (geo.height() - h) / 2 };
    setPosition(pos.x(), pos.y());
    update();
}

void TaoFrameLessView::setIsMax(bool isMax)
{
    if (m_isMax == isMax)
        return;

    m_isMax = isMax;
    emit isMaxChanged(m_isMax);
}

#if WIN32
const long border_width = 6;
#if QT_VERSION >= QT_VERSION_CHECK(6, 0, 0)
bool TaoView::nativeEvent(const QByteArray &eventType, void *message, qintptr *result)
#else
bool TaoFrameLessView::nativeEvent(const QByteArray &eventType, void *message, long *result)
#endif
{
    if (!result) {
        return false;
    }
    MSG *msg = reinterpret_cast<MSG *>(message);
    if (!msg || (msg && !msg->hwnd)) {
        return false;
    }
    switch (msg->message) {
        case WM_NCCALCSIZE: {
            const auto mode = static_cast<BOOL>(msg->wParam);
            *result = mode ? WVR_REDRAW : 0;

            const auto clientRect = mode ? &(reinterpret_cast<LPNCCALCSIZE_PARAMS>(msg->lParam)->rgrc[0]) : reinterpret_cast<LPRECT>(msg->lParam);
            //规避 拖动border进行resize时界面闪烁
            if (!isMaxWin(this) && !isFullWin(this)) {
                if (clientRect->top != 0)
                {
                    clientRect->top -= 1;
                }
            } else {
                if (clientRect->top != 0)
                {
                    clientRect->top += 1;
                }
            }
            return true;
        }
        case WM_NCHITTEST: {
            *result = 0;

            RECT winrect;
            GetWindowRect(HWND(winId()), &winrect);

            long x = GET_X_LPARAM(msg->lParam);
            long y = GET_Y_LPARAM(msg->lParam);

            *result = 0;
            if (!isMaxWin(this) && !isFullWin(this)) { //非最大化、非全屏时，进行命中测试，处理边框拖拽
                *result = hitTest(winrect, x, y, border_width);
                if (0 != *result) {
                    return true;
                }
            }

            if (m_titleItem)
            {
                auto titlePos = m_titleItem->mapToGlobal(m_titleItem->position());
                titlePos = mapFromGlobal(titlePos.toPoint());
                auto titleRect = QRect(titlePos.x(), titlePos.y(), m_titleItem->width(), m_titleItem->height());
                double dpr = qApp->devicePixelRatio();
                QPoint pos = mapFromGlobal(QPoint(x / dpr, y / dpr));
                if (titleRect.contains(pos)) {
                    *result = HTCAPTION;
                    return true;
                }
            }
            return false;
        } //end case WM_NCHITTEST
    }
    return QQuickView::nativeEvent(eventType, message, result);
}
#endif
