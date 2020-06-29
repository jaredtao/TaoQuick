#pragma once

#include "ITaoQuickPlugin.h"
class TaoQuickPlugin : public QObject, public ITaoQuickPlugin {

    Q_OBJECT
    Q_PLUGIN_METADATA(IID TaoQuickInterface_iid)
    Q_INTERFACES(ITaoQuickPlugin)
public:
    explicit TaoQuickPlugin(QObject *parent = nullptr);

    void init() override;
    QJsonArray infos() const override;
};
