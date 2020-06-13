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
            {"name", u8"Basic"},
            { "children", QJsonArray{
                              QJsonObject {
                                  {"name", u8"Button"},
                                  {"url", "qrc:/Qml/Contents/BaseComponent/Buttons.qml"}
                                  },
                              QJsonObject {
                                  {"name", u8"Drag"},
                                  {"url", "qrc:/Qml/Contents/BaseComponent/Drags.qml"},
                                  },
                              QJsonObject {
                                  {"name", u8"Gradient"},
                                  {"url", "qrc:/Qml/Contents/BaseComponent/Gradiants.qml"},
                                  },
                              QJsonObject {
                                  {"name", u8"ProgressBar"},
                                  {"url", "qrc:/Qml/Contents/BaseComponent/Progresses.qml"},
                                  },
                              QJsonObject {
                                  {"name", u8"Dialog"},
                                  {"url", "qrc:/Qml/Contents/BaseComponent/Dialogs.qml"}
                                  },
                              }
            }
        },
        QJsonObject {
            {"name", u8"ShaderEffect"},
            { "children", QJsonArray{
                              QJsonObject {
                                  {"name", u8"Cloud Hole"},
                                  {"url", "qrc:/Qml/Contents/ShaderEffect/CloudHole.qml"}
                              },
                              QJsonObject {
                                  {"name", u8"Star Light"},
                                  {"url", "qrc:/Qml/Contents/ShaderEffect/Planet.qml"}
                              },
                              QJsonObject {
                                  {"name", u8"Snail"},
                                  {"url", "qrc:/Qml/Contents/ShaderEffect/Snail.qml"}
                              },
                              QJsonObject {
                                  {"name", u8"Super Mario"},
                                  {"url", "qrc:/Qml/Contents/ShaderEffect/SuperMario.qml"}
                              }
                          }
            }
        }
    };
    return arr;
}
