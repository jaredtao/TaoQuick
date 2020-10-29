#pragma once

#include <QAbstractListModel>
#include "TaoCommonGlobal.h"
class QuickItemBase;
class TAO_API QuickListModelBase : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit QuickListModelBase(QObject *parent = nullptr);
    ~QuickListModelBase() override;

public:
    //[begin] query data
    int      rowCount(const QModelIndex &parent) const override;
    Q_INVOKABLE QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    Q_INVOKABLE QVariant data(int row, int role = Qt::DisplayRole) const;
    //[end] query data

    //[begin] reset data
    void                          resetData(const QList<QuickItemBase *> &objs);
    const QList<QuickItemBase *> &datas() const
    {
        return mObjs;
    }
    //[end] reset data

    //[begin] add data
    void append(const QList<QuickItemBase *> &objs);
    void prepend(QuickItemBase *obj);
    void insert(int row, const QList<QuickItemBase *> &objs);
    //[end] add data

    //[begin] remove data
    void clear();
    void removeAt(int row);
    //[end] remove data

    //[begin] update data
    void updateData(int row, QuickItemBase *obj);
    //[end] update data

public:
    virtual void updateCalcInfo() {}

protected:
    QList<QuickItemBase *> mObjs;
};
