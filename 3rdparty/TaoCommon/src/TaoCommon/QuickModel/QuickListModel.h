#pragma once

#include "Common/PropertyHelper.h"
#include "QuickListItemBase.h"
#include "QuickModelBase.hpp"
#include "TaoCommonGlobal.h"
#include <QTimer>

class TAO_API QuickListModel : public QuickModelBase<QuickListItemBase*>
{
private:
    Q_OBJECT
    Q_PROPERTY(bool allChecked READ allChecked WRITE setAllChecked NOTIFY allCheckedChanged)

    Q_PROPERTY(int visibledCount READ visibledCount WRITE set_visibledCount NOTIFY visibledCountChanged FINAL)
    Q_PROPERTY(int selectedCount READ selectedCount WRITE set_selectedCount NOTIFY selectedCountChanged FINAL)
    Q_PROPERTY(int checkedCount READ checkedCount WRITE set_checkedCount NOTIFY checkedCountChanged FINAL)

    Q_PROPERTY(QStringList headerRoles READ headerRoles WRITE set_headerRoles NOTIFY headerRolesChanged FINAL)
    Q_PROPERTY(Qt::SortOrder sortOrder READ sortOrder WRITE set_sortOrder NOTIFY sortOrderChanged FINAL)
    Q_PROPERTY(QString sortRole READ sortRole WRITE set_sortRole NOTIFY sortRoleChanged FINAL)
    Q_PROPERTY(QStringList noSortRoles READ noSortRoles WRITE set_noSortRoles NOTIFY noSortRolesChanged FINAL)

    //      AUTO_PROPERTY_V2(int, visibledCount, 0)
    //      AUTO_PROPERTY_V2(int, selectedCount, 0)
    //      AUTO_PROPERTY_V2(int, checkedCount, 0)

    //      AUTO_PROPERTY_V2(QStringList, headerRoles, {})
    //      AUTO_PROPERTY_V2(Qt::SortOrder, sortOrder, Qt::AscendingOrder)
    //      AUTO_PROPERTY_V2(QString, sortRole, {})
    //      AUTO_PROPERTY_V2(QStringList, noSortRoles, {})
    // signals:
    //      void visibledCountChanged(int);
    //      void selectedCountChanged(int);
    //      void checkedCountChanged(int);
    //      void headerRolesChanged(const QStringList&);
    //      void sortOrderChanged(Qt::SortOrder);
    //      void sortRoleChanged(const QString&);
    //      void noSortRolesChanged(const QStringList&);

public:
    using Super = QuickModelBase<QuickListItemBase*>;
    explicit QuickListModel(QObject* parent = nullptr);
    ~QuickListModel() override;
    Q_INVOKABLE QVariant data(int row) const
    {
        return Super::data(row);
    }
    //[begin] check
    bool allChecked() const
    {
        return mAllChecked;
    }
    Q_INVOKABLE void check(int row, bool checked);
    //[end] check

    //[begin] search. control visible
    Q_INVOKABLE void search(const QString& searchKey);
    const QString& searchKey() const
    {
        return mSearchkey;
    }
    Q_INVOKABLE void searchImmediate(const QString& searchKey);
    Q_INVOKABLE void clearSearchKey()
    {
        mSearchkey.clear();
    }
    //[end] search

    using VisibleCallback = std::function<bool(QuickListItemBase*)>;
    void setVisibleFilter(const VisibleCallback& callback)
    {
        mVisibleCallback = callback;
    }

    QList<QuickListItemBase*> allCheckedDatas() const;

    //[begin] select
    Q_INVOKABLE void deselectAll();
    Q_INVOKABLE void selectAll();
    Q_INVOKABLE bool isSelected(int row) const;
    Q_INVOKABLE void select(int row);
    Q_INVOKABLE void deselect(int row);
    Q_INVOKABLE void selectRange(int from, int to);
    Q_INVOKABLE void selectSingle(int row);
    //[end] select

    Q_INVOKABLE void doPress(int row, bool shift, bool ctrl, bool outRange);
    Q_INVOKABLE void doMove(int row, bool outRange);
    Q_INVOKABLE void doRelease();

    //[begin] sort

    using SortCallback = std::function<bool(QuickListItemBase*, QuickListItemBase*)>;
    // Map <key, callBack> ,key should match to headerRoles
    void setSortCallbacksAscend(const QMap<QString, SortCallback>& callbacksMap)
    {
        mSortCallbacksAscend = callbacksMap;
    }

    Q_INVOKABLE virtual void sortByRole();
    //[end] sort

    void updateCalcInfo() override;

    Q_INVOKABLE void notifyScrollTo(int index)
    {
        emit scrollTo(index);
    }
    int visibledCount() const;
    void set_visibledCount(int newVisibleCount);

    int selectedCount() const;
    void set_selectedCount(int newSelectedCount);

    int checkedCount() const;
    void set_checkedCount(int newCheckedCount);

    QStringList headerRoles() const;
    void set_headerRoles(const QStringList& newHeaderRoles);

    Qt::SortOrder sortOrder() const;
    void set_sortOrder(Qt::SortOrder newSortOrder);

    QString sortRole() const;
    void set_sortRole(const QString& newSortRole);

    QStringList noSortRoles() const;
    void set_noSortRoles(const QStringList& newNoSortRoles);

public slots:
    void setAllChecked(bool allChecked);

signals:
    void scrollTo(int index);
    void allCheckedChanged(bool allChecked);

    void selectedAction();

    void signalUpdateCalcCount();

    void beginSearch();
    void endSearch();
    void visibledCountChanged();

    void selectedCountChanged();

    void checkedCountChanged();

    void headerRolesChanged();

    void sortOrderChanged();

    void sortRoleChanged();

    void noSortRolesChanged();

protected slots:
    void onSearch();

protected:
    void updateAllCheck();
    void updateVisibleCount();
    void updateSelectedCount();
    void updateCheckedCount();
    void updateAlternate();

protected:
    bool mAllChecked = false;
    bool mIsPressed = false;
    int m_visibledCount = 0;

    int m_selectedCount = 0;

    int m_checkedCount = 0;

    QStringList m_headerRoles;

    Qt::SortOrder m_sortOrder = Qt::AscendingOrder;

    QString m_sortRole;

    QStringList m_noSortRoles;
    int mLastPressedRow = -1;

    QMap<QString, SortCallback> mSortCallbacksAscend;
    QString mSearchkey;
    QTimer mSearchTimer;
    VisibleCallback mVisibleCallback;
};
