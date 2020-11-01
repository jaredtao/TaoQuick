#include "QuickTool.h"
#include <QQuickItem>
QuickTool::QuickTool(QObject *parent) : QObject(parent) {}

QuickTool::QuickTool(QObject *rootObject, QObject *parent)
    : QObject(parent), pRootObject(rootObject)
{
}

QuickTool::~QuickTool() {}
void QuickTool::findRootByNode(QObject *nodeObject)
{
    pRootObject = nodeObject;
    if (pRootObject) {
        QObject *pParent = nullptr;
        while ((pParent = pRootObject->parent())) {
            pRootObject = pParent;
        }
    }
}
QRect QuickTool::getItemGeometryToScene(const QString &targetObjName) const
{
    if (!pRootObject) {
        return {};
    }
    auto pItem = pRootObject->findChild<QQuickItem *>(targetObjName);
    if (pItem) {
        if (pItem->parentItem()) {
            auto pos = pItem->parentItem()->mapToScene(pItem->position());
            return QRectF { pos.x(), pos.y(), pItem->width(), pItem->height() }.toRect();
        } else {
            return pItem->boundingRect().toRect();
        }
    }
    return {};
}

QObject *QuickTool::getObject(const QString &targetObjName) const
{
    if (!pRootObject) {
        return nullptr;
    }
    return pRootObject->findChild<QObject *>(targetObjName);
}

QVariant QuickTool::getObjectProperty(QObject *targetObj, const QString &propertyName) const
{
    return targetObj->property(propertyName.toUtf8().constData());
}

void QuickTool::setObjectProperty(QObject *targetObj, const QString &propertyName,
                                  const QVariant &value) const
{
    targetObj->setProperty(propertyName.toUtf8().constData(), value);
}

QVariant QuickTool::getObjectProperty(const QString &targetObjName,
                                      const QString &propertyName) const
{
    auto pObj = getObject(targetObjName);
    if (pObj) {
        return getObjectProperty(pObj, propertyName);
    }
    return {};
}

void QuickTool::setObjectProperty(const QString &targetObjName, const QString &propertyName,
                                  const QVariant &value) const
{
    auto pObj = getObject(targetObjName);
    if (pObj) {
        setObjectProperty(pObj, propertyName, value);
    }
}
