#include "QuickTool.h"
#include <QGuiApplication>
#include <QQuickItem>
QuickTool::QuickTool(QObject* parent)
    : QObject(parent)
{
}

QuickTool::QuickTool(QObject* rootObject, QObject* parent)
    : QObject(parent)
    , pRootObject(rootObject)
{
}

QuickTool::~QuickTool() { }
void QuickTool::findRootByNode(QObject* nodeObject)
{
    pRootObject = nodeObject;
    if (pRootObject)
    {
        QObject* pParent = nullptr;
        while ((pParent = pRootObject->parent()))
        {
            pRootObject = pParent;
        }
    }
}
QRect QuickTool::getItemGeometryToScene(const QString& targetObjName) const
{
    if (!pRootObject)
    {
        return {};
    }
    auto pItem = pRootObject->findChild<QQuickItem*>(targetObjName);
    if (pItem)
    {
        if (pItem->parentItem())
        {
            auto pos = pItem->parentItem()->mapToScene(pItem->position());
            return QRectF { pos.x(), pos.y(), pItem->width(), pItem->height() }.toRect();
        }
        else
        {
            return pItem->boundingRect().toRect();
        }
    }
    return {};
}

void QuickTool::setAppOverrideCursor(QCursor cursor)
{
    qApp->setOverrideCursor(cursor);
}

void QuickTool::restoreAppOverrideCursor()
{
    qApp->restoreOverrideCursor();
}

QPoint QuickTool::cursorGlobalPos() const
{
    return QCursor::pos();
}

void QuickTool::setMoveItemOnWindow(QQuickItem* item, QWindow* window)
{
    if (!item || !window)
    {
        return;
    }
    pMoveItem = item;
    pMoveWindow = window;
    pMoveWindow->installEventFilter(this);
}

bool QuickTool::eventFilter(QObject* watched, QEvent* e)
{
    if (watched == pMoveWindow)
    {
        if (e->type() == QEvent::MouseButtonPress)
        {
            QMouseEvent* pE = static_cast<QMouseEvent*>(e);
            if (pE && !mPressed)
            {
                if (pMoveItem->boundingRect().contains(pE->pos()))
                {
                    mPressed = true;
                }
            }
        }
        else if (e->type() == QEvent::MouseButtonRelease)
        {
            mPressed = false;
        }
        else if (e->type() == QEvent::MouseMove)
        {
            QMouseEvent* pE = static_cast<QMouseEvent*>(e);
            if (pE && mPressed)
            {
                if (pMoveItem->boundingRect().contains(pE->pos()))
                {
                    pMoveWindow->startSystemMove();
                }
            }
        }
    }

    return Super::eventFilter(watched, e);
}

QObject* QuickTool::getObject(const QString& targetObjName) const
{
    if (!pRootObject)
    {
        return nullptr;
    }
    return pRootObject->findChild<QObject*>(targetObjName);
}

QVariant QuickTool::getObjectProperty(QObject* targetObj, const QString& propertyName) const
{
    return targetObj->property(propertyName.toUtf8().constData());
}

void QuickTool::setObjectProperty(QObject* targetObj, const QString& propertyName, const QVariant& value) const
{
    targetObj->setProperty(propertyName.toUtf8().constData(), value);
}

QVariant QuickTool::getObjectProperty(const QString& targetObjName, const QString& propertyName) const
{
    auto pObj = getObject(targetObjName);
    if (pObj)
    {
        return getObjectProperty(pObj, propertyName);
    }
    return {};
}

void QuickTool::setObjectProperty(const QString& targetObjName, const QString& propertyName, const QVariant& value) const
{
    auto pObj = getObject(targetObjName);
    if (pObj)
    {
        setObjectProperty(pObj, propertyName, value);
    }
}
