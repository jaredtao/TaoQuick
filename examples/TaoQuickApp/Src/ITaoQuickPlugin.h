#pragma once
#include <QJsonArray>
#include <QtPlugin>
//ITaoQuickPlugin 插件接口
class ITaoQuickPlugin {
public:
    virtual ~ITaoQuickPlugin() {}
    //插件初始化
    virtual void init() = 0;
    //获取插件内容,Json格式为
    // [name: qsTr("首页"), title: qsTr("欢迎"), url: "qrc:/Qml/Contents/Welcome/Welcome.qml", children: []]
    //或者
    // [
    //      name: qsTr("基础组件"); title: qsTr("基础组件"); children: [
    //          { name: qsTr("按钮组件"); title: qsTr("按钮组件"); url: "qrc:/Qml/Contents/BaseComponent/Buttons.qml"}
    //      ]
    // ]
    virtual QJsonArray infos() const = 0;
    //翻译
    virtual void replaceTranslater(const QString &oldLang, const QString &newLang) const = 0;
};
#define TaoQuickInterface_iid "jaredtao.github.io/TaoQuick"
Q_DECLARE_INTERFACE(ITaoQuickPlugin, TaoQuickInterface_iid)
