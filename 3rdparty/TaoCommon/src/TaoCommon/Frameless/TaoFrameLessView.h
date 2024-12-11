#pragma once
#include "Common/PropertyHelper.h"
#include "TaoCommonGlobal.h"
#include <QMouseEvent>
#include <QQuickView>
#include <QRegion>

// 简易的无边框窗口，主要用来实现自定义标题栏。
// 支持标题栏拖动和边缘改变大小，不做深度处理
struct TaoFrameLessViewPrivate;
class TAO_API TaoFrameLessView : public QQuickView
{
    Q_OBJECT
    using Super = QQuickView;
    AUTO_PROPERTY(int, borderWidth, 4)
public:
    explicit TaoFrameLessView(QWindow* parent = nullptr);
    ~TaoFrameLessView();

    static QRect calcCenterGeo(const QRect& screenGeo, const QSize& normalSize);
public slots:
    void moveToScreenCenter();
    void move(int x, int y);

    QPoint mousePosition() const;

    QPoint globalPosToWindowPos(const QPoint& pos) const;
signals:
    void mousePressed(int xPos, int yPos, int button);

protected:
    void mousePressEvent(QMouseEvent* event) override;
    void mouseReleaseEvent(QMouseEvent* event) override;
    void mouseMoveEvent(QMouseEvent* event) override;

    Qt::Edges getPosEdges(const QPoint& pos) const;
    Qt::CursorShape getCursorShapeByEdge(const Qt::Edges& edges);

    void doMoveTo(const QPoint& nowPos);

private:
    std::unique_ptr<TaoFrameLessViewPrivate> d;
};
