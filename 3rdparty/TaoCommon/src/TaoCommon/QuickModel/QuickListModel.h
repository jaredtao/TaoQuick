#pragma once

#include "Common/PropertyHelper.h"
#include "QuickListItemBase.h"
#include "QuickModelBase.hpp"
#include "TaoCommonGlobal.h"
#include <QTimer>

class TAO_API QuickListModel : public QuickModelBase<QuickListItemBase*>
{
    Q_OBJECT
    Q_PROPERTY(bool allChecked READ allChecked WRITE setAllChecked NOTIFY allCheckedChanged)
    AUTO_PROPERTY(int, visibledCount, 0)
    AUTO_PROPERTY(int, selectedCount, 0)
    AUTO_PROPERTY(int, checkedCount, 0)

    AUTO_PROPERTY(QStringList, headerRoles, {})
    AUTO_PROPERTY(Qt::SortOrder, sortOrder, Qt::AscendingOrder)
    AUTO_PROPERTY(QString, sortRole, {})
    AUTO_PROPERTY(QStringList, noSortRoles, {})
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
public slots:
    void setAllChecked(bool allChecked);

signals:
    void scrollTo(int index);
    void allCheckedChanged(bool allChecked);

    void selectedAction();

    void signalUpdateCalcCount();

    void beginSearch();
    void endSearch();
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

    int mLastPressedRow = -1;

    QMap<QString, SortCallback> mSortCallbacksAscend;
    QString mSearchkey;
    QTimer mSearchTimer;
    VisibleCallback mVisibleCallback;
};
