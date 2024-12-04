#pragma once

#include "Common/PropertyHelper.h"
#include "TaoCommonGlobal.h"
#include <QObject>
class TAO_API QuickListItemBase : public QObject
{
    Q_OBJECT
    AUTO_PROPERTY_V2(bool, isChecked, false)
    AUTO_PROPERTY_V2(bool, isSelected, false)
    AUTO_PROPERTY_V2(bool, isAlternate, false)
signals:
    void isCheckedChanged(bool);
    void isSelectedChanged(bool);
    void isAlternateChanged(bool);

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

private:
};
