pragma Singleton

import QtQuick 2.9

QtObject {
    id: config
    objectName: "config"
    property string fontFamily: "微软雅黑"
    property int fontPixel: 14
    property int fixedHeight: 30

    property int maximumLength: 64

    property int controlBorderRadius: 4

    property int scrollBarRadius: 2
    property int scrollBarMinLen: 40
    property int scrollBarSize: 10
    property int scrollBarSize_Smaller: 5
    property int tipTextPixel: 12

    property string imagePathPrefix: "file:///./../Images/"
    Component.onCompleted: {
        if (typeof (taoQuickImagePath) != "undefined"
            && taoQuickImagePath !== null && taoQuickImagePath.length > 0) {
            imagePathPrefix = taoQuickImagePath
        }
        currentTheme = 0
    }

    property color themeColor
    property color backgroundColor
    property color textColor
    property color splitLineColor

    Behavior on themeColor {
        ColorAnimation {
            duration: 400
        }
    }
    Behavior on backgroundColor {
        ColorAnimation {
            duration: 400
        }
    }
    Behavior on textColor {
        ColorAnimation {
            duration: 400
        }
    }

    property int currentTheme: -1
    onCurrentThemeChanged: {
        var t = themes.get(currentTheme)
        themeColor = t.themeColor
        backgroundColor = t.backgroundColor
        textColor = t.textColor
        if (typeof (t.splitLineColor) != "undefined" && t.splitLineColor) {
            splitLineColor = t.splitLineColor
        }
    }
    property ListModel themes: ListModel {
        ListElement {
            name: "Red"
            themeColor: "#c62f2f"
            backgroundColor: "#f6f6f6"
            textColor: "#5c5c5c"
            splitLineColor: "#c62f2f"
        }
        ListElement {
            name: "Black"
            themeColor: "#222225"
            backgroundColor: "#272c25"
            textColor: "#adafb2"
        }
        ListElement {
            name: "Pink"
            themeColor: "#faa0c5"
            backgroundColor: "#f6f6f6"
            textColor: "#5c5c5c"
        }
        ListElement {
            name: "Gold"
            themeColor: "#fed98f"
            backgroundColor: "#f6f6f6"
            textColor: "#5c5c5c"
        }
        ListElement {
            name: "Green"
            themeColor: "#58c979"
            backgroundColor: "#f6f6f6"
            textColor: "#5c5c5c"
        }
        ListElement {
            name: "Blue"
            themeColor: "#67c1fd"
            backgroundColor: "#f6f6f6"
            textColor: "#5c5c5c"
        }
    }
    property color invalidColor: Qt.tint(backgroundColor, "#10FF0000")
    property color alterColor: Qt.darker(backgroundColor, 2.0)
    property color tipBackgroundColor: Qt.lighter(backgroundColor, 1.2)
    property color tipBorderColor: Qt.darker(themeColor, 2.0)

    property color textColor_disabled: Qt.lighter(textColor, 3.0)
    property color textColor_hovered: Qt.lighter(themeColor, 1.2)
    property color textColor_pressed: Qt.lighter(themeColor, 1.4)

    property color controlColor: Qt.darker(backgroundColor, 1.0)
    property color controlColor_hovered: Qt.darker(backgroundColor, 1.1)
    property color controlColor_pressed: Qt.darker(backgroundColor, 1.2)
    property color controlColor_disabled: Qt.darker(backgroundColor, 2.0)

    property color controlBorderColor: Qt.darker(backgroundColor, 2.0)
    property color controlBorderColor_hovered: Qt.darker(themeColor, 1.1)
    property color controlBorderColor_pressed: Qt.darker(themeColor, 1.2)
    property color controlBorderColor_disabled: Qt.darker(backgroundColor, 3.0)

    property color scrollBarBackgroundColor: Qt.darker(backgroundColor, 2.0)

}
