#pragma once

#include <QQuickView>

class TaoView : public QQuickView
{
    Q_OBJECT
public:
    explicit TaoView(QWindow *parent = nullptr);
    ~TaoView();

    Q_INVOKABLE void initAppInfo();

    void moveToScreenCenter();
protected:
#if WIN32
    bool nativeEvent(const QByteArray &eventType, void *message, long *result) override;
#endif
};

