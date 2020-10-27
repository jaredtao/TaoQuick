#pragma once

#include <QObject>
#include "QuickModel/QuickListModel.h"
class DeviceAddModel : public QuickListModel
{
    Q_OBJECT
public:
    explicit DeviceAddModel(QObject *parent = nullptr);

public slots:
    void doUpdateName(int row, const QString &name);
signals:

};

