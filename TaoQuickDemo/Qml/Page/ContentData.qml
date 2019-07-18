import QtQuick 2.12
QtObject {

    property color titleBackground: "#c62f2f"
    property color background: "#f6f6f6"
    property color reserverColor: "#ffffff"
    property color textColor: "black"
    property color splitColor: "gray"

    property int currentTheme: 0
    onCurrentThemeChanged: {
        var t = themes.get(currentTheme)
        titleBackground = t.titleBackground
        background = t.background
        textColor = t.textColor
    }
    property ListModel themes: ListModel {
        ListElement {
            name: qsTr("一品红")
            titleBackground: "#c62f2f"
            background: "#f6f6f6"
            textColor: "#5c5c5c"
        }
        ListElement {
            name: qsTr("高冷黑")
            titleBackground: "#222225"
            background: "#272c25"
            textColor: "#adafb2"
        }
        ListElement {
            name: qsTr("淑女粉")
            titleBackground: "#faa0c5"
            background: "#f6f6f6"
            textColor: "#5c5c5c"
        }
        ListElement {
            name: qsTr("富贵金")
            titleBackground: "#fed98f"
            background: "#f6f6f6"
            textColor: "#5c5c5c"
        }
        ListElement {
            name: qsTr(" 清爽绿")
            titleBackground: "#58c979"
            background: "#f6f6f6"
            textColor: "#5c5c5c"
        }
        ListElement {
            name: qsTr("苍穹蓝")
            titleBackground: "#67c1fd"
            background: "#f6f6f6"
            textColor: "#5c5c5c"
        }
    }

    property ListModel contentData: ListModel {
        ListElement { name: qsTr("首页"); title: qsTr("欢迎"); url: "qrc:/Qml/Contents/Welcome/Welcome.qml"; children: []}
        ListElement {
            name: qsTr("基础组件"); title: qsTr("基础组件"); children: [
                ListElement { name: qsTr("按钮组件"); title: qsTr("按钮组件"); url: "qrc:/Qml/Contents/BaseComponent/Buttons.qml"},
                ListElement { name: qsTr("拖动组件"); title: qsTr("拖动组件"); url: "qrc:/Qml/Contents/BaseComponent/Drags.qml"},
                ListElement { name: qsTr("渐变"); title: qsTr("渐变"); url: "qrc:/Qml/Contents/BaseComponent/Gradiants.qml"},
                ListElement { name: qsTr("进度条组件"); title: qsTr("进度条组件"); url: "qrc:/Qml/Contents/BaseComponent/Progresses.qml"},
                ListElement { name: qsTr("对话框"); title: qsTr("对话框"); url: "qrc:/Qml/Contents/BaseComponent/Dialogs.qml"}
            ]
        }
        ListElement {
            name: qsTr("ShaderEffect"); title: qsTr("ShaderEffect"); children: [
                ListElement { name: qsTr("穿云洞"); title: qsTr("穿云洞"); url: "qrc:/Qml/Contents/ShaderEffect/CloudHole.qml"},
                ListElement { name: qsTr("星球之光"); title: qsTr("星球之光"); url: "qrc:/Qml/Contents/ShaderEffect/Planet.qml"},
                ListElement { name: qsTr("蜗牛"); title: qsTr("蜗牛"); url: "qrc:/Qml/Contents/ShaderEffect/Snail.qml"},
                ListElement { name: qsTr("超级马里奥"); title: qsTr("超级马里奥"); url: "qrc:/Qml/Contents/ShaderEffect/SuperMario.qml"}
            ]
        }
    }
}
