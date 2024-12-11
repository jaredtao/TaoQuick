#include "Frameless/TaoFrameLessView.h"
#include <QGuiApplication>
#include <QQuickItem>
#include <QScreen>
#include <QWindow>

struct TaoFrameLessViewPrivate
{
    uint32_t mPressedEdge;
    QRect mPressedGeometry;
};
TaoFrameLessView::TaoFrameLessView(QWindow* parent)
    : Super(parent)
    , d(std::make_unique<TaoFrameLessViewPrivate>())
{
    setFlags(flags() | Qt::FramelessWindowHint | Qt::Window);
    setResizeMode(SizeRootObjectToView);
}
TaoFrameLessView::~TaoFrameLessView() { }
QRect TaoFrameLessView::calcCenterGeo(const QRect& screenGeo, const QSize& normalSize)
{
    int w = normalSize.width();
    int h = normalSize.height();
    int x = screenGeo.x() + (screenGeo.width() - w) / 2;
    int y = screenGeo.y() + (screenGeo.height() - h) / 2;
    if (screenGeo.width() < w)
    {
        x = screenGeo.x();
        w = screenGeo.width();
    }
    if (screenGeo.height() < h)
    {
        y = screenGeo.y();
        h = screenGeo.height();
    }

    return { x, y, w, h };
}
void TaoFrameLessView::moveToScreenCenter()
{
    auto geo = calcCenterGeo(screen()->availableGeometry(), size());
    if (minimumWidth() > geo.width() || minimumHeight() > geo.height())
    {
        setMinimumSize(geo.size());
    }
    setGeometry(geo);
    update();
}

void TaoFrameLessView::move(int x, int y)
{
    setPosition(x, y);
}

QPoint TaoFrameLessView::mousePosition() const
{
    return QCursor::pos();
}

QPoint TaoFrameLessView::globalPosToWindowPos(const QPoint& pos) const
{
    return mapFromGlobal(pos);
}

void TaoFrameLessView::mousePressEvent(QMouseEvent* event)
{
    auto mousePos = event->pos();
    emit mousePressed(mousePos.x(), mousePos.y(), event->button());
    d->mPressedEdge = getPosEdges(mousePos);
    if (d->mPressedEdge)
    {
        d->mPressedGeometry = geometry();
    }
    Super::mousePressEvent(event);
}

void TaoFrameLessView::mouseReleaseEvent(QMouseEvent* event)
{
    d->mPressedEdge = 0;
    d->mPressedGeometry = {};
    Super::mouseReleaseEvent(event);
}

void TaoFrameLessView::mouseMoveEvent(QMouseEvent* event)
{
    {
        // 实时计算光标
        auto edges = getPosEdges(event->pos());
        auto shape = getCursorShapeByEdge(edges);
        setCursor(shape);
    }
    {
        // 根据按下时位置执行move
        if (d->mPressedEdge)
        {
            doMoveTo(event->pos());
        }
    }
    Super::mouseMoveEvent(event);
}
Qt::CursorShape TaoFrameLessView::getCursorShapeByEdge(const Qt::Edges& edges)
{
    switch (edges)
    {
    case Qt::Edge::TopEdge:
    case Qt::Edge::BottomEdge: {
        return Qt::CursorShape::SizeVerCursor;
        break;
    }
    case Qt::Edge::LeftEdge:
    case Qt::Edge::RightEdge: {
        return Qt::CursorShape::SizeHorCursor;
        break;
    }
    case (Qt::Edge::TopEdge | Qt::Edge::LeftEdge):
    case (Qt::Edge::BottomEdge | Qt::Edge::RightEdge): {
        return Qt::CursorShape::SizeFDiagCursor;
        break;
    }
    case (Qt::Edge::TopEdge | Qt::Edge::RightEdge):
    case (Qt::Edge::BottomEdge | Qt::Edge::LeftEdge): {
        return Qt::CursorShape::SizeBDiagCursor;
        break;
    }
    default:
        break;
    }
    return Qt::CursorShape::ArrowCursor;
}

void TaoFrameLessView::doMoveTo(const QPoint& nowPos)
{
    switch (d->mPressedEdge)
    {
    case Qt::Edge::TopEdge: {
        auto gPos = mapToGlobal(nowPos);
        auto newGeo = d->mPressedGeometry.adjusted(0, gPos.y() - d->mPressedGeometry.top(), 0, 0);
        // setGeometry(newGeo);
        setY(newGeo.y());
        setHeight(newGeo.height());
        break;
    }
    case Qt::Edge::BottomEdge: {
        auto gPos = mapToGlobal(nowPos);
        auto newGeo = d->mPressedGeometry.adjusted(0, 0, 0, gPos.y() - d->mPressedGeometry.bottom());
        setGeometry(newGeo);
        break;
    }
    case Qt::Edge::LeftEdge: {
        auto gPos = mapToGlobal(nowPos);
        auto newGeo = d->mPressedGeometry.adjusted(gPos.x() - d->mPressedGeometry.left(), 0, 0, 0);
        setGeometry(newGeo);
        break;
    }
    case Qt::Edge::RightEdge: {
        auto gPos = mapToGlobal(nowPos);
        auto newGeo = d->mPressedGeometry.adjusted(0, 0, gPos.x() - d->mPressedGeometry.right(), 0);
        setGeometry(newGeo);
        break;
    }
    case (Qt::Edge::TopEdge | Qt::Edge::LeftEdge): {
        auto gPos = mapToGlobal(nowPos);
        auto newGeo = d->mPressedGeometry.adjusted(gPos.x() - d->mPressedGeometry.left(), gPos.y() - d->mPressedGeometry.top(), 0, 0);
        setGeometry(newGeo);
        break;
    }
    case (Qt::Edge::BottomEdge | Qt::Edge::RightEdge): {
        auto gPos = mapToGlobal(nowPos);
        auto newGeo = d->mPressedGeometry.adjusted(0, 0, gPos.x() - d->mPressedGeometry.right(), gPos.y() - d->mPressedGeometry.bottom());
        setGeometry(newGeo);
        break;
    }
    case (Qt::Edge::TopEdge | Qt::Edge::RightEdge): {
        auto gPos = mapToGlobal(nowPos);
        auto newGeo = d->mPressedGeometry.adjusted(0, gPos.y() - d->mPressedGeometry.top(), gPos.x() - d->mPressedGeometry.right(), 0);
        setGeometry(newGeo);
        break;
    }
    case (Qt::Edge::BottomEdge | Qt::Edge::LeftEdge): {
        auto gPos = mapToGlobal(nowPos);
        auto newGeo = d->mPressedGeometry.adjusted(gPos.x() - d->mPressedGeometry.left(), 0, 0, gPos.y() - d->mPressedGeometry.bottom());
        setGeometry(newGeo);
        break;
    }
    default:
        break;
    }
}
Qt::Edges TaoFrameLessView::getPosEdges(const QPoint& pos) const
{
    uint32_t edges = 0;
    if (pos.x() < 0 || pos.x() > width())
    {
        return (Qt::Edges)edges;
    }
    if (pos.y() < 0 || pos.y() > height())
    {
        return (Qt::Edges)edges;
    }
    if (pos.x() <= borderWidth())
    {
        edges |= Qt::Edge::LeftEdge;
    }
    else if (width() - borderWidth() <= pos.x())
    {
        edges |= Qt::Edge::RightEdge;
    }
    if (pos.y() <= borderWidth())
    {
        edges |= Qt::Edge::TopEdge;
    }
    else if (height() - borderWidth() <= pos.y())
    {
        edges |= Qt::Edge::BottomEdge;
    }
    return (Qt::Edges)edges;
}
