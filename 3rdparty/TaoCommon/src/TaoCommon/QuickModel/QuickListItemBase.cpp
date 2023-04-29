#include "QuickModel/QuickListItemBase.h"

QuickListItemBase::QuickListItemBase(QObject* parent)
    : QObject(parent)
{
}

QuickListItemBase::~QuickListItemBase() { }

QuickListItemBase::QuickListItemBase(const QuickListItemBase& other)
    : QuickListItemBase(nullptr)
{
    setIsChecked(other.isChecked());
    setIsSelected(other.isSelected());
    setIsVisible(other.isVisible());
    setIsAlternate(other.isAlternate());
}
