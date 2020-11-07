#pragma once

#include <QObject>
#include "TaoModel/TaoListModel.h"
class DeviceAddModel : public TaoListModel
{
    Q_OBJECT
public:
    explicit DeviceAddModel(QObject *parent = nullptr);

public slots:
    void doUpdateName(int row, const QString &name);

    void initData();

    void addOne();
    void addMulti(int count);

    void clearAll()
    {
        clear();
    }
signals:

};

