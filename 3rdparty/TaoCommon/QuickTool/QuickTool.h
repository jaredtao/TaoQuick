#pragma once
#include <QObject>
#include <QVariant>
#include <QRect>
#include "TaoCommonGlobal.h"
class TAO_API QuickTool : public QObject
{
    Q_OBJECT
public:
    QuickTool(QObject *parent = nullptr);
    QuickTool(QObject *rootObject, QObject *parent = nullptr);
    virtual ~QuickTool() override;
    void setRootObjet(QObject *rootObj)
    {
        pRootObject = rootObj;
    }
    QObject *rootObject() const
    {
        return pRootObject;
    }
    void findRootByNode(QObject *nodeObject);
public slots:
    QObject *getObject(const QString &targetObjName) const;

    QVariant getObjectProperty(QObject *targetObj, const QString &propertyName) const;
    void setObjectProperty(QObject *targetObj, const QString &propertyName,
                           const QVariant &value) const;

    QVariant getObjectProperty(const QString &targetObjName, const QString &propertyName) const;
    void setObjectProperty(const QString &targetObjName, const QString &propertyName,
                           const QVariant &value) const;

    QRect getItemGeometryToScene(const QString &targetObjName) const;

private:
    QObject *pRootObject = nullptr;
};
