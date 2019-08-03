#pragma once

#include "ITaoQuickPlugin.h"
class EffectsPlugin : public QObject, public ITaoQuickPlugin {

    Q_OBJECT
    Q_PLUGIN_METADATA(IID TaoQuickInterface_iid)
    Q_INTERFACES(ITaoQuickPlugin)
public:
    explicit EffectsPlugin(QObject *parent = nullptr);

    void init() override;
    QJsonArray infos() const override;
    void replaceTranslater(const QString &oldLang, const QString &newLang) const override;
};
