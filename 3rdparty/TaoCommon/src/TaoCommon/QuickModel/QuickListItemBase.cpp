#include "QuickModel/QuickListItemBase.h"

QuickListItemBase::QuickListItemBase(QObject* parent)
    : QObject(parent)
{
}

QuickListItemBase::~QuickListItemBase() { }

bool QuickListItemBase::isChecked() const
{
    return m_isChecked;
}

void QuickListItemBase::set_isChecked(bool newIsChecked)
{
    if (m_isChecked == newIsChecked)
        return;
    m_isChecked = newIsChecked;
    emit isCheckedChanged();
}

bool QuickListItemBase::isSelected() const
{
    return m_isSelected;
}

void QuickListItemBase::set_isSelected(bool newIsSelected)
{
    if (m_isSelected == newIsSelected)
        return;
    m_isSelected = newIsSelected;
    emit isSelectedChanged();
}

bool QuickListItemBase::isAlternate() const
{
    return m_isAlternate;
}

void QuickListItemBase::set_isAlternate(bool newIsAlternate)
{
    if (m_isAlternate == newIsAlternate)
        return;
    m_isAlternate = newIsAlternate;
    emit isAlternateChanged();
}
