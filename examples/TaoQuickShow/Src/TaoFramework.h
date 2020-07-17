#pragma once
#include "Common/objectmap.h"
#include "TaoObject.h"
#include <QObject>
class QQmlContext;
class QQuickView;
class TaoFramework {
public:
    static TaoFramework* instance()
    {
        static TaoFramework framework;
        return &framework;
    }
    ~TaoFramework();

public:
    //初始化
    void init();
    //反初始化
    void uninit();
    //ui加载之前，做的处理
    void beforeUiReady(QQmlContext* ctx);
    //ui加载完成时，做的处理
    void afterUiReady();
public:
    //创建TaoObject
    template <class TaoObjectType>
    void createObject(QObject *parent = nullptr)
    {
        m_objMap.createObject<TaoObjectType>(parent);
    }
    //销毁TaoObject
    template <class TaoObjectType>
    bool destoryObject()
    {
        return m_objMap.destroyObject<TaoObjectType>();
    }
    //获取TaoObject
    template <class TaoObjectType>
    TaoObjectType *getObject() const
    {
        return m_objMap.getObject<TaoObjectType>();
    }

    QQuickView *getMainView() const
    {
        return m_mainView;
    }
    void setMainView(QQuickView *mainView)
    {
        m_mainView = mainView;
    }
private:
    TaoFramework() {}

private:
    TaoCommon::CObjectMap<TaoObject> m_objMap;
    QQuickView *m_mainView = nullptr;
};
