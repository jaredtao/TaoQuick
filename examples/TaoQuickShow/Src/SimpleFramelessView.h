#ifndef SIMPLEFRAMELESSVIEW_H
#define SIMPLEFRAMELESSVIEW_H

#include <QObject>
#include <QQmlEngine>
#include <QQuickItem>
#include <QQuickView>
struct SimpleFramelessViewPrivate;
class SimpleFramelessView : public QQuickView
{
	Q_OBJECT
	QML_ELEMENT
	using Super = QQuickView;

public:
	SimpleFramelessView(QWindow* parent = nullptr);
	~SimpleFramelessView();
	void moveToScreenCenter();

public:
signals:
	void mousePressed(int xPos, int yPos, int button);
public slots:
	void move(int x, int y);

	QPoint mousePosition() const;

	QPoint globalPosToWindowPos(const QPoint& pos) const;

protected:
	void mousePressEvent(QMouseEvent* event) override;
	void mouseReleaseEvent(QMouseEvent* event) override;
	void mouseMoveEvent(QMouseEvent* event) override;

private:
private:
	std::unique_ptr<SimpleFramelessViewPrivate> d;
};

#endif // SIMPLEFRAMELESSVIEW_H
