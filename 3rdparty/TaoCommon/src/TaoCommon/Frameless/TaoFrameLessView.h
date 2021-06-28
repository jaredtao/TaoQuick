#pragma once
#include "TaoCommonGlobal.h"
#include <QQuickView>
#include <QRegion>
//无边框窗口，主要用来实现自定义标题栏。
//Windows平台支持拖动和改变大小，支持Aero效果
//非Windows平台，去掉边框，不做其它处理。由Qml模拟resize和拖动。
class TaoFrameLessViewPrivate;
class TAO_API TaoFrameLessView : public QQuickView
{
    Q_OBJECT
    using Super = QQuickView;
    Q_PROPERTY(bool isMax READ isMax NOTIFY isMaxChanged)
public:
    explicit TaoFrameLessView(QWindow *parent = nullptr);
    ~TaoFrameLessView();
    void moveToScreenCenter();
    bool isMax() const;
    QQuickItem *titleItem() const;

    static QRect calcCenterGeo(const QRect &screenGeo, const QSize &normalSize);
public slots:
    void setIsMax(bool isMax);
    void setTitleItem(QQuickItem* item);

    //设置圆角
    void setCornerRadius(int radius)
    {
        QRect rect(QPoint(), this->geometry().size());
        QRect circleRect(0, 0, radius * 2, radius * 2);

        QRegion region(circleRect, QRegion::Ellipse);

        circleRect.moveRight(rect.right());
        region += QRegion(circleRect, QRegion::Ellipse);

        circleRect.moveBottom(rect.bottom());
        region += QRegion(circleRect, QRegion::Ellipse);

        circleRect.moveLeft(rect.left());
        region += QRegion(circleRect, QRegion::Ellipse);

        region += QRegion(rect.adjusted(radius, 0, -radius, 0), QRegion::Rectangle);
        region += QRegion(rect.adjusted(0, radius, 0, -radius), QRegion::Rectangle);

        this->setMask(region);
    }
signals:
    void isMaxChanged(bool isMax);

protected:
#    if QT_VERSION >= QT_VERSION_CHECK(6, 0, 0)
    bool nativeEvent(const QByteArray &eventType, void *message, qintptr *result) override;
#    else
    bool nativeEvent(const QByteArray &eventType, void *message, long *result) override;
#    endif

private:
    TaoFrameLessViewPrivate *d;
};
