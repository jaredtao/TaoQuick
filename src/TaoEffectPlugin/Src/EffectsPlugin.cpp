#include "EffectsPlugin.h"
#include <QQmlEngine>
EffectsPlugin::EffectsPlugin(QObject *parent) : QObject(parent) {}

void EffectsPlugin::init()
{
    Q_INIT_RESOURCE(Qml);
}

QJsonArray EffectsPlugin::infos() const
{
    static QJsonArray arr{
        QJsonObject{
            { "name", u8"特效" },
            { "title", u8"特效" },
            { "children",
              QJsonArray{ QJsonObject{ { "name", u8"环" }, { "title", u8"环" }, { "url", "qrc:/Effect/Qml/ContentPage/Effect/RingPage.qml" } },
                          QJsonObject{ { "name", u8"璀璨星空" }, { "title", u8"璀璨星空" }, { "url", "qrc:/Effect/Qml/ContentPage/Effect/Swapper.qml" } },
                          QJsonObject{ { "name", u8"跟上节奏" }, { "title", u8"跟上节奏" }, { "url", "qrc:/Effect/Qml/ContentPage/Effect/SoundByte.qml" } },
                          QJsonObject{ { "name", u8"暗流涌动" }, { "title", u8"暗流涌动" }, { "url", "qrc:/Effect/Qml/ContentPage/Effect/Arrow.qml" } },
                          QJsonObject{ { "name", u8"魔力圈圈" }, { "title", u8"魔力圈圈" }, { "url", "qrc:/Effect/Qml/ContentPage/Effect/ARound.qml" } } } },
        },

        QJsonObject{
            { "name", u8"自绘" },
            { "title", u8"自绘" },
            { "children",
              QJsonArray{ QJsonObject{ { "name", u8"圆角矩形" }, { "title", u8"圆角矩形" }, { "url", "qrc:/Effect/Qml/ContentPage/Shape/RoundRect.qml" } },
                          QJsonObject{ { "name", u8"K线" }, { "title", u8"K线" }, { "url", "qrc:/Effect/Qml/ContentPage/Shape/KLine.qml" } } } } },
        QJsonObject{
            { "name", u8"动画" },
            { "title", u8"动画" },
            { "children",
              QJsonArray{ QJsonObject{ { "name", u8"缓慢进入" }, { "title", u8"缓慢进入" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Enter.qml" } },
                          QJsonObject{ { "name", u8"梯度" }, { "title", u8"梯度" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Grad.qml" } },
                          QJsonObject{ { "name", u8"劈裂" }, { "title", u8"劈裂" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Cleavage.qml" } },
                          QJsonObject{ { "name", u8"对角线" }, { "title", u8"对角线" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Diagonal.qml" } },
                          QJsonObject{ { "name", u8"百叶窗" }, { "title", u8"百叶窗" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Louver.qml" } },
                          QJsonObject{ { "name", u8"方盒" }, { "title", u8"方盒" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Square.qml" } },
                          QJsonObject{ { "name", u8"圆盒" }, { "title", u8"圆盒" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Circle.qml" } },
                          QJsonObject{ { "name", u8"十字" }, { "title", u8"十字" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Cross.qml" } },
                          QJsonObject{ { "name", u8"菱形" }, { "title", u8"菱形" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Rhombus.qml" } },
                          QJsonObject{ { "name", u8"轮子" }, { "title", u8"轮子" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Wheel.qml" } },
                          QJsonObject{ { "name", u8"棋盘" }, { "title", u8"棋盘" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Board.qml" } },
                          QJsonObject{ { "name", u8"溶解" }, { "title", u8"溶解" }, { "url", "qrc:/Effect/Qml/ContentPage/Animation/Dissolve.qml" } } } } },
        QJsonObject{
            { "name", u8"页面切换" },
            { "title", u8"页面切换" },
            { "children",
              QJsonArray{ QJsonObject{ { "name", u8"淡入淡出" }, { "title", u8"淡入淡出" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/FadeInOut.qml" } },
                          QJsonObject{ { "name", u8"梯度" }, { "title", u8"梯度" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Grad.qml" } },
                          QJsonObject{ { "name", u8"劈裂" }, { "title", u8"劈裂" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Cleavage.qml" } },
                          QJsonObject{ { "name", u8"对角线" }, { "title", u8"对角线" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Diagonal.qml" } },
                          QJsonObject{ { "name", u8"百叶窗" }, { "title", u8"百叶窗" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Louver.qml" } },
                          QJsonObject{ { "name", u8"方盒" }, { "title", u8"方盒" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Square.qml" } },
                          QJsonObject{ { "name", u8"圆盒" }, { "title", u8"圆盒" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Circle.qml" } },
                          QJsonObject{ { "name", u8"十字" }, { "title", u8"十字" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Cross.qml" } },
                          QJsonObject{ { "name", u8"菱形" }, { "title", u8"菱形" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Rhombus.qml" } },
                          QJsonObject{ { "name", u8"轮子" }, { "title", u8"轮子" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Wheel.qml" } },
                          QJsonObject{ { "name", u8"扇形" }, { "title", u8"扇形" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Sector.qml" } },
                          QJsonObject{ { "name", u8"棋盘" }, { "title", u8"棋盘" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Board.qml" } },
                          QJsonObject{ { "name", u8"溶解" }, { "title", u8"溶解" }, { "url", "qrc:/Effect/Qml/ContentPage/PageSwitch/Dissolve.qml" } } } } }
    };
    return arr;
}

void EffectsPlugin::replaceTranslater(const QString &oldLang, const QString &newLang) const
{
    (void)oldLang;
    (void)newLang;
}
