#pragma once

#include <QQuickView>
//无边框窗口，支持拖动和改变大小，支持Windows平台Aero效果
class TaoView : public QQuickView
{
    Q_OBJECT
    using Super = QQuickView;
    Q_PROPERTY(bool isMax READ isMax NOTIFY isMaxChanged)
public:
    explicit TaoView(QWindow *parent = nullptr);
    ~TaoView();
    void moveToScreenCenter();
    bool isMax() const
    {
        return m_isMax;
    }

public slots:
    void setIsMax(bool isMax);

signals:
    void isMaxChanged(bool isMax);

protected:

#if WIN32
#if QT_VERSION >= QT_VERSION_CHECK(6, 0, 0)
    bool nativeEvent(const QByteArray &eventType, void *message, qintptr *result) override;
#else
    bool nativeEvent(const QByteArray &eventType, void *message, long *result) override;
#endif
#endif
private:
    bool m_isMax;
};

