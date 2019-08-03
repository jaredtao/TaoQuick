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
        ListElement { name: qsTr("首页"); title: qsTr("欢迎"); url: "qrc:/Qml/Welcome/Welcome.qml"; children: []}
    }
}
