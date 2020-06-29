#pragma once
#include <QJsonArray>
#include <QtPlugin>
//ITaoQuickPlugin 插件接口
class ITaoQuickPlugin
{
public:
    virtual ~ITaoQuickPlugin() {}
    //插件初始化
    virtual void init() = 0;
    //获取插件内容,Json格式为
    // [name: "首页", title: "欢迎", url: "qrc:/Qml/Contents/Welcome/Welcome.qml", children: []]
    //或者
    // [
    //      name: "基础组件"; title: "基础组件"; children: [
    //          { name: "按钮组件"; title: "按钮组件"; url: "qrc:/Qml/Contents/BaseComponent/Buttons.qml"}
    //      ]
    // ]
    virtual QJsonArray infos() const = 0;

    virtual void uninit() {}
};
#define TaoQuickInterface_iid "jaredtao.github.io/TaoQuick"
Q_DECLARE_INTERFACE(ITaoQuickPlugin, TaoQuickInterface_iid)
