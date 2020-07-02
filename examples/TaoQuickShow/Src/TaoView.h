#pragma once

#include <QQuickView>
//无边框窗口，支持拖动和改变大小
class TaoView : public QQuickView
{
    Q_OBJECT
    using Super = QQuickView;
    Q_PROPERTY(bool isMax READ isMax NOTIFY isMaxChanged)
public:
    explicit TaoView(QWindow *parent = nullptr);
    ~TaoView();

    Q_INVOKABLE void initAppInfo();

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
    bool nativeEvent(const QByteArray &eventType, void *message, long *result) override;
#endif
private:
    bool m_isMax;
};

