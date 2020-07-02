#pragma once

#include <QQuickView>

class TaoView : public QQuickView
{
    Q_OBJECT
    using Super = QQuickView;
public:
    explicit TaoView(QWindow *parent = nullptr);
    ~TaoView();

    Q_INVOKABLE void initAppInfo();

    void moveToScreenCenter();
protected:

    void mouseMoveEvent(QMouseEvent *) override;
    void mousePressEvent(QMouseEvent *) override;
    void mouseReleaseEvent(QMouseEvent *) override;

#if WIN32
    bool nativeEvent(const QByteArray &eventType, void *message, long *result) override;
#endif
private:
    bool m_pressed = false;
    QPoint m_pressedPos;
};

