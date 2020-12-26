#pragma once
#include "TaoCommonGlobal.h"
#include <QQuickView>
//无边框窗口，实现自定义标题栏。支持拖动和改变大小，支持Windows平台Aero效果
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
    void setTitleItem(QQuickItem *item);
signals:
    void isMaxChanged(bool isMax);

protected:
#if WIN32
#    if QT_VERSION >= QT_VERSION_CHECK(6, 0, 0)
    bool nativeEvent(const QByteArray &eventType, void *message, qintptr *result) override;
#    else
    bool nativeEvent(const QByteArray &eventType, void *message, long *result) override;
#    endif
#endif
private:
    TaoFrameLessViewPrivate *d;
};
