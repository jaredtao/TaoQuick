#include "TaoQuickPlugin.h"
#include <QQmlEngine>
TaoQuickPlugin::TaoQuickPlugin(QObject *parent) : QObject (parent)
{
}

void TaoQuickPlugin::init()
{
    Q_INIT_RESOURCE(Qml);
}

    QJsonArray TaoQuickPlugin::infos() const
{
    static QJsonArray arr {
        QJsonObject {
            {"name", u8"基础组件"},
            {"title",u8"基础组件"},
            { "children", QJsonArray{
                              QJsonObject {
                                  {"name", u8"按钮组件"},
                                  {"title",u8"按钮组件"},
                                  {"url", "qrc:/Qml/Contents/BaseComponent/Buttons.qml"}
                                  },
                              QJsonObject {
                                  {"name", u8"拖动组件"},
                                  {"title",u8"拖动组件"},
                                  {"url", "qrc:/Qml/Contents/BaseComponent/Drags.qml"},
                                  },
                              QJsonObject {
                                  {"name", u8"渐变"},
                                  {"title",u8"渐变"},
                                  {"url", "qrc:/Qml/Contents/BaseComponent/Gradiants.qml"},
                                  },
                              QJsonObject {
                                  {"name", u8"进度条组件"},
                                  {"title",u8"进度条组件"},
                                  {"url", "qrc:/Qml/Contents/BaseComponent/Progresses.qml"},
                                  },
                              QJsonObject {
                                  {"name", u8"对话框"},
                                  {"title",u8"对话框"},
                                  {"url", "qrc:/Qml/Contents/BaseComponent/Dialogs.qml"}
                                  },
                              }
            }
        },
        QJsonObject {
            {"name", u8"ShaderEffect"},
            {"title",u8"ShaderEffect"},
            { "children", QJsonArray{
                              QJsonObject {
                                  {"name", u8"穿云洞"},
                                  {"title",u8"穿云洞"},
                                  {"url", "qrc:/Qml/Contents/ShaderEffect/CloudHole.qml"}
                              },
                              QJsonObject {
                                  {"name", u8"星球之光"},
                                  {"title",u8"星球之光"},
                                  {"url", "qrc:/Qml/Contents/ShaderEffect/Planet.qml"}
                              },
                              QJsonObject {
                                  {"name", u8"蜗牛"},
                                  {"title",u8"蜗牛"},
                                  {"url", "qrc:/Qml/Contents/ShaderEffect/Snail.qml"}
                              },
                              QJsonObject {
                                  {"name", u8"超级马里奥"},
                                  {"title",u8"超级马里奥"},
                                  {"url", "qrc:/Qml/Contents/ShaderEffect/SuperMario.qml"}
                              }
                          }
            }
        }
    };
    return arr;
}

void TaoQuickPlugin::replaceTranslater(const QString &oldLang, const QString &newLang) const
{
    (void)oldLang;
    (void)newLang;
}
