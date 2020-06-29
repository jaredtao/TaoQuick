#include "EffectsPlugin.h"
#include <QQmlEngine>
EffectsPlugin::EffectsPlugin(QObject* parent)
    : QObject(parent)
{
}

void EffectsPlugin::init()
{
    Q_INIT_RESOURCE(Qml);
}

QJsonArray EffectsPlugin::infos() const
{
    static QJsonArray arr {
        QJsonObject {
            { "name", u8"Effect" },
            { "children",
                QJsonArray { QJsonObject { { "name", u8"Ring" }, { "url", "qrc:/Effect/Qml/ContentPage/Effect/RingPage.qml" } },
                    QJsonObject { { "name", u8"Brilliant Starry Sky" },  { "url", "qrc:/Effect/Qml/ContentPage/Effect/Swapper.qml" } },
                    QJsonObject { { "name", u8"Keep up with the pace" },{ "url", "qrc:/Effect/Qml/ContentPage/Effect/SoundByte.qml" } },
                    QJsonObject { { "name", u8"Undercurrent surge" },{ "url", "qrc:/Effect/Qml/ContentPage/Effect/Arrow.qml" } },
                    QJsonObject { { "name", u8"Magic Circle" }, { "url", "qrc:/Effect/Qml/ContentPage/Effect/ARound.qml" } } } },
        },

        QJsonObject {
            { "name", u8"Painter" },
            { "children",
                QJsonArray { QJsonObject { { "name", u8"RoundRect" },  { "url", "qrc:/Effect/Qml/ContentPage/Shape/RoundRect.qml" } },
                    QJsonObject { { "name", u8"KLine" }, { "url", "qrc:/Effect/Qml/ContentPage/Shape/KLine.qml" } } } } },
        QJsonObject {
            { "name", u8"Animation" },
            { "children",
                QJsonArray { QJsonObject { { "name", u8"Enter" },  { "url", "qrc:/Effect/Qml/ContentPage/Animation/Enter.qml" } },
                    QJsonObject { { "name", u8"Grad" },  { "url", "qrc:/Effect/Qml/ContentPage/Animation/Grad.qml" } },
                    QJsonObject { { "name", u8"Cleavage" },  { "url", "qrc:/Effect/Qml/ContentPage/Animation/Cleavage.qml" } },
                    QJsonObject { { "name", u8"Diagonal" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Diagonal.qml" } },
                    QJsonObject { { "name", u8"Louver" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Louver.qml" } },
                    QJsonObject { { "name", u8"Square" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Square.qml" } },
                    QJsonObject { { "name", u8"Circle" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Circle.qml" } },
                    QJsonObject { { "name", u8"Cross" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Cross.qml" } },
                    QJsonObject { { "name", u8"Rhombus" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Rhombus.qml" } },
                    QJsonObject { { "name", u8"Wheel" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Wheel.qml" } },
                    QJsonObject { { "name", u8"Board" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Board.qml" } },
                    QJsonObject { { "name", u8"Dissolve" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Dissolve.qml" } } } } },
        QJsonObject {
            { "name", u8"PageSwitch" },
            { "children",
                QJsonArray { QJsonObject { { "name", u8"FadeInOut" },{ "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/FadeInOut.qml" } },
                    QJsonObject { { "name", u8"Grad" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Grad.qml" } },
                    QJsonObject { { "name", u8"Cleavage" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Cleavage.qml" } },
                    QJsonObject { { "name", u8"Diagonal" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Diagonal.qml" } },
                    QJsonObject { { "name", u8"Louver" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Louver.qml" } },
                    QJsonObject { { "name", u8"Square" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Square.qml" } },
                    QJsonObject { { "name", u8"Circle" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Circle.qml" } },
                    QJsonObject { { "name", u8"Cross" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Cross.qml" } },
                    QJsonObject { { "name", u8"Rhombus" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Rhombus.qml" } },
                    QJsonObject { { "name", u8"Wheel" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Wheel.qml" } },
                    QJsonObject { { "name", u8"Sector" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Sector.qml" } },
                    QJsonObject { { "name", u8"Board" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Board.qml" } },
                    QJsonObject { { "name", u8"Dissolve" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Dissolve.qml" } } } } }
    };
    return arr;
}
