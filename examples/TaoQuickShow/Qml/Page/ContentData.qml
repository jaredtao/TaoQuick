import QtQuick 2.9
QtObject {

    property string fontFamily: "微软雅黑"
    property int fontPixel: 14
    property color themeColor: themes.get(0).themeColor
    property color background: themes.get(0).background
    property color textColor: themes.get(0).textColor
    property color reserverColor: "#ffffff"
    property color splitColor: "gray"
    Behavior on themeColor {
        ColorAnimation {
            duration: 400
        }
    }
    Behavior on background {
        ColorAnimation {
            duration: 400
        }
    }
    Behavior on textColor {
        ColorAnimation {
            duration: 400
        }
    }
    property int currentTheme: 0
    onCurrentThemeChanged: {
        var t = themes.get(currentTheme)
        themeColor = t.themeColor
        background = t.background
        textColor = t.textColor
    }
    property ListModel themes: ListModel {
        ListElement {
            name: "Red"
            themeColor: "#c62f2f"
            background: "#f6f6f6"
            textColor: "#5c5c5c"
        }
        ListElement {
            name: "Black"
            themeColor: "#222225"
            background: "#272c25"
            textColor: "#adafb2"
        }
        ListElement {
            name: "Pink"
            themeColor: "#faa0c5"
            background: "#f6f6f6"
            textColor: "#5c5c5c"
        }
        ListElement {
            name: "Gold"
            themeColor: "#fed98f"
            background: "#f6f6f6"
            textColor: "#5c5c5c"
        }
        ListElement {
            name: "Green"
            themeColor: "#58c979"
            background: "#f6f6f6"
            textColor: "#5c5c5c"
        }
        ListElement {
            name: "Blue"
            themeColor: "#67c1fd"
            background: "#f6f6f6"
            textColor: "#5c5c5c"
        }
    }
}
