#pragma once

#include <QObject>
#include "TaoCommonGlobal.h"
class TAO_API TaoListItemBase : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isChecked READ isChecked WRITE setIsChecked NOTIFY isCheckedChanged)
    Q_PROPERTY(bool isSelected READ isSelected WRITE setIsSelected NOTIFY isSelectedChanged)
    Q_PROPERTY(bool isVisible READ isVisible WRITE setIsVisible NOTIFY isVisibleChanged)
    Q_PROPERTY(bool isAlternate READ isAlternate WRITE setIsAlternate NOTIFY isAlternateChanged)
public:
    explicit TaoListItemBase(QObject *parent = nullptr);
    ~TaoListItemBase() override;
    bool isChecked() const { return mIsChecked; }

    bool isSelected() const { return mIsSelected; }

    bool isVisible() const { return mIsVisible; }
    bool isAlternate() const { return mIsAlternate; }
    // Model call this for search. return true if contents match key, others return false.
    virtual bool match(const QString &key)
    {
        Q_UNUSED(key)
        return true;
    }
public slots:
    void setIsChecked(bool isChecked)
    {
        if (mIsChecked == isChecked)
            return;

        mIsChecked = isChecked;
        emit isCheckedChanged(mIsChecked);
    }

    void setIsSelected(bool isSelected)
    {
        if (mIsSelected == isSelected)
            return;

        mIsSelected = isSelected;
        emit isSelectedChanged(mIsSelected);
    }

    void setIsVisible(bool isVisible)
    {
        if (mIsVisible == isVisible)
            return;

        mIsVisible = isVisible;
        emit isVisibleChanged(mIsVisible);
    }
    void setIsAlternate(bool isAlternate)
    {
        if (mIsAlternate == isAlternate) {
            return;
        }
        mIsAlternate = isAlternate;
        emit isAlternateChanged(mIsAlternate);
    }

signals:
    void isCheckedChanged(bool isChecked);

    void isSelectedChanged(bool isSelected);

    void isVisibleChanged(bool isVisible);

    void isAlternateChanged(bool isAlternate);

private:
    bool mIsChecked = false;
    bool mIsSelected = false;
    bool mIsVisible = true;
    bool mIsAlternate = false;
};
