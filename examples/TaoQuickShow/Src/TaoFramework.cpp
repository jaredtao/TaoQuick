#include "TaoFramework.h"
#include <QQmlContext>
TaoFramework *TaoFramework::instance()
{
    static TaoFramework framework;
    return &framework;
}

TaoFramework::~TaoFramework()
{
    uninit();
}

void TaoFramework::init()
{
    m_objMap.forEach([](TaoObject* obj) { obj->init(); });
}

void TaoFramework::uninit()
{
    m_objMap.forEach([](TaoObject* obj) { obj->uninit(); });
    m_objMap.clear();
}

void TaoFramework::beforeUiReady(QQmlContext* ctx)
{
    m_objMap.forEach([ctx](TaoObject* obj) {
        obj->beforeUiReady(ctx);
    });
}

void TaoFramework::afterUiReady()
{
    m_objMap.forEach([](TaoObject* obj) { obj->afterUiReady(); });
}
