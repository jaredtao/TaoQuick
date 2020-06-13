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
};

