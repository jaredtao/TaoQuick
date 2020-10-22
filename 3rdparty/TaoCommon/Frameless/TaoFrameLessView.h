#pragma once
#include "taocommonglobal.h"
#include <QQuickView>
//无边框窗口，支持拖动和改变大小，支持Windows平台Aero效果
class TAO_API TaoFrameLessView : public QQuickView
{
    Q_OBJECT
    using Super = QQuickView;
    Q_PROPERTY(bool isMax READ isMax NOTIFY isMaxChanged)
public:
    explicit TaoFrameLessView(QWindow *parent = nullptr);
    ~TaoFrameLessView();
    void moveToScreenCenter();
    bool isMax() const
    {
        return m_isMax;
    }
    QQuickItem *titleItem() const
    {
        return m_titleItem;
    }
public slots:
    void setIsMax(bool isMax);
    void setTitleItem(QQuickItem *item);
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
    QQuickItem *m_titleItem = nullptr;
};

