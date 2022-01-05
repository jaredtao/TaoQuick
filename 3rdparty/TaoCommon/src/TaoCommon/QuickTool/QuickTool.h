#pragma once
#include <QCursor>
#include <QEvent>
#include <QObject>
#include <QQuickItem>
#include <QRect>
#include <QVariant>
#include <QWindow>
class QuickTool : public QObject
{
    Q_OBJECT
    using Super = QObject;

public:
    explicit QuickTool(QObject* parent = nullptr);
    explicit QuickTool(QObject* rootObject, QObject* parent = nullptr);
    virtual ~QuickTool() override;
    void setRootObjet(QObject* rootObj)
    {
        pRootObject = rootObj;
    }
    QObject* rootObject() const
    {
        return pRootObject;
    }
    void findRootByNode(QObject* nodeObject);

public:
    Q_INVOKABLE QObject* getObject(const QString& targetObjName) const;

    Q_INVOKABLE QVariant getObjectProperty(QObject* targetObj, const QString& propertyName) const;
    Q_INVOKABLE void setObjectProperty(QObject* targetObj, const QString& propertyName, const QVariant& value) const;

    Q_INVOKABLE QVariant getObjectProperty(const QString& targetObjName, const QString& propertyName) const;
    Q_INVOKABLE void setObjectProperty(const QString& targetObjName, const QString& propertyName, const QVariant& value) const;

    Q_INVOKABLE QRect getItemGeometryToScene(const QString& targetObjName) const;

    Q_INVOKABLE void setAppOverrideCursor(QCursor cursor);
    Q_INVOKABLE void restoreAppOverrideCursor();

    Q_INVOKABLE QPoint cursorGlobalPos() const;

private:
    QObject* pRootObject = nullptr;
};
