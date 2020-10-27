#pragma once

#include <QObject>
#include "QuickModel/QuickListModel.h"
class DeviceAddModel : public QuickListModel
{
    Q_OBJECT
public:
    explicit DeviceAddModel(QObject *parent = nullptr);

signals:

};

