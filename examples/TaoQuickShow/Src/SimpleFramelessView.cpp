#include "SimpleFramelessView.h"

struct SimpleFramelessViewPrivate
{
};
SimpleFramelessView::SimpleFramelessView(QWindow* parent) : Super(parent), d(std::make_unique<SimpleFramelessViewPrivate>())
{
	setFlags(Qt::FramelessWindowHint | Qt::Window);
	setResizeMode(Super::ResizeMode::SizeRootObjectToView);
}

SimpleFramelessView::~SimpleFramelessView() {}

static QRect calcCenterGeo(const QRect& screenGeo, const QSize& normalSize)
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
void SimpleFramelessView::moveToScreenCenter()
{
	auto geo = calcCenterGeo(screen()->availableGeometry(), size());
	if (minimumWidth() > geo.width() || minimumHeight() > geo.height())
	{
		setMinimumSize(geo.size());
	}
	setGeometry(geo);
	update();
}

void SimpleFramelessView::move(int x, int y)
{
	setPosition(x, y);
}

QPoint SimpleFramelessView::mousePosition() const
{
	return QCursor::pos();
}

QPoint SimpleFramelessView::globalPosToWindowPos(const QPoint& pos) const
{
	return mapFromGlobal(pos);
}

static QPoint getEventPos(QMouseEvent* event)
{
#if QT_VERSION >= QT_VERSION_CHECK(6, 0, 0)
	return event->position().toPoint();
#else
	return QPoint{ event->x(), event->y() };
#endif
}

void SimpleFramelessView::mousePressEvent(QMouseEvent* event)
{
	auto mousePos = getEventPos(event);
	emit mousePressed(mousePos.x(), mousePos.y(), event->button());

	Super::mousePressEvent(event);
}

void SimpleFramelessView::mouseReleaseEvent(QMouseEvent* event)
{
	// d->mTitlePressed = false;
	// qWarning() << "released";
	Super::mouseReleaseEvent(event);
}

void SimpleFramelessView::mouseMoveEvent(QMouseEvent* event)
{
	// if (d->mTitlePressed)
	// {
	// 	auto mousePos = getEventPos(event);
	// 	qWarning() << "moved";
	// 	auto pos = mousePos - d->mTitlePressedPos;
	// 	setPosition(pos);
	// }
	Super::mouseMoveEvent(event);
}
