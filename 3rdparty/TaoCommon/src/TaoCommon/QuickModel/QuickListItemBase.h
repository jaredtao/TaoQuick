#pragma once

#include "Common/PropertyHelper.h"
#include "TaoCommonGlobal.h"
#include <QObject>
class TAO_API QuickListItemBase : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isChecked READ isChecked WRITE set_isChecked NOTIFY isCheckedChanged)
    Q_PROPERTY(bool isSelected READ isSelected WRITE set_isSelected NOTIFY isSelectedChanged)
    Q_PROPERTY(bool isAlternate READ isAlternate WRITE set_isAlternate NOTIFY isAlternateChanged FINAL)

    // AUTO_PROPERTY_V2(bool, isChecked, false)
    // AUTO_PROPERTY_V2(bool, isSelected, false)
    // AUTO_PROPERTY_V2(bool, isAlternate, false)
    // signals:
    // void isCheckedChanged(bool);
    // void isSelectedChanged(bool);
    // void isAlternateChanged(bool);

public:
    explicit QuickListItemBase(QObject* parent = nullptr);
    virtual ~QuickListItemBase() override;
    QuickListItemBase(const QuickListItemBase& other)
    {
        set_isChecked(other.isChecked());
        set_isSelected(other.isSelected());
        set_isAlternate(other.isAlternate());
    }

    QuickListItemBase& operator=(const QuickListItemBase& other)
    {
        set_isChecked(other.isChecked());
        set_isSelected(other.isSelected());
        set_isAlternate(other.isAlternate());
        return *this;
    }
    // Model call this for search. return true if contents match key, others return false.
    virtual bool match(const QString& key)
    {
        Q_UNUSED(key)
        return true;
    }

    bool isChecked() const;
    void set_isChecked(bool newIsChecked);

    bool isSelected() const;
    void set_isSelected(bool newIsSelected);

    bool isAlternate() const;
    void set_isAlternate(bool newIsAlternate);

signals:
    void isCheckedChanged();

    void isSelectedChanged();

    void isAlternateChanged();

private:
    bool m_isChecked = false;
    bool m_isSelected = false;
    bool m_isAlternate = false;
};
