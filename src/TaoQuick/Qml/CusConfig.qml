pragma Singleton

import QtQuick 2.9

QtObject {
    id: config
    objectName: "config"
    property string fontFamily: "微软雅黑"
    property string transString: typeof (trans) != "undefined" ? trans.transString : ""
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
        if (typeof (taoQuickImagePath) != "undefined" && taoQuickImagePath !== null && taoQuickImagePath.length > 0) {
            imagePathPrefix = taoQuickImagePath
        }
        currentTheme = 0
    }

    property color themeColor
    property color backgroundColor
    property color textColor

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

    property color imageColor_hovered: Qt.darker(themeColor, 1.2)
    property color imageColor_pressed: Qt.darker(themeColor, 1.4)

    property color controlBorderColor_hovered: Qt.darker(themeColor, 1.2)
    property color controlBorderColor_pressed: Qt.darker(themeColor, 1.4)

    property color controlColor
    property color controlColor_hovered: Qt.darker(themeColor, 1.2)
    property color controlColor_pressed: Qt.darker(themeColor, 1.4)
    property color controlColor_disabled: Qt.lighter(controlColor, 2.0)
    property color controlBorderColor_disabled: controlColor_disabled

    property color splitLineColor
    property color invalidColor
    property color alterColor

    property color tipBackgroundColor
    property color tipBorderColor

    property color textColor_disabled
    property color textColor_hovered
    property color textColor_pressed

    property color controlBorderColor
    property color imageColor
    property color imageColor_disabled

    property color scrollBarBackgroundColor
    property color scrollBarBackgroundColor_hovered

    property int currentTheme: -1
    onCurrentThemeChanged: {
        var t = themes.get(currentTheme)
        themeColor = t.themeColor
        backgroundColor = t.backgroundColor
        textColor = t.textColor

        splitLineColor = t.splitLineColor
        invalidColor = t.invalidColor
        alterColor = t.alterColor

        tipBackgroundColor = t.tipBackgroundColor
        tipBorderColor = t.tipBorderColor

        textColor_disabled = t.textColor_disabled
        textColor_hovered = t.textColor_hovered
        textColor_pressed = t.textColor_pressed
        controlColor = t.controlColor
        controlBorderColor = t.controlBorderColor
        imageColor = t.imageColor
        imageColor_disabled = t.imageColor_disabled

        scrollBarBackgroundColor = t.scrollBarBackgroundColor
        scrollBarBackgroundColor_hovered = t.scrollBarBackgroundColor_hovered
    }
    property ListModel themes: ListModel {
        ListElement {
            name: "Red"
            themeColor: "#ec4141"
            backgroundColor: "#ffffff"
            textColor: "#282828"

            splitLineColor:"#f38d8d"
            invalidColor: "#e29696"
            alterColor: "#8a8a9b"
            tipBackgroundColor: "#ffffff"
            tipBorderColor: "#767676"

            textColor_disabled: "#9f9fcf"
            textColor_hovered: "#686868"
            textColor_pressed: "#212121"

            controlColor: "#f5f5f6"
            controlBorderColor: "#cbcbcb"
            imageColor: "#373737"
            imageColor_disabled: "#9f9fcf"
            scrollBarBackgroundColor: "#e0e0e0"
            scrollBarBackgroundColor_hovered: "#cfcfd1"
        }
        ListElement {
            name: "Black"
            themeColor: "#222225"
            backgroundColor: "#2b2b2b"
            textColor: "#d0d0d0"

            splitLineColor:"#2d2d30"
            invalidColor: "#782c2c"
            alterColor: "#383838"
            tipBackgroundColor: "#ffffff"
            tipBorderColor: "#767676"

            textColor_disabled: "#877a66"
            textColor_hovered: "#ffffff"
            textColor_pressed: "#d2d2d2"
            controlColor: "#333333"
            controlBorderColor: "#555555"
            imageColor: "#adafb2"
            imageColor_disabled: "#989898"
            scrollBarBackgroundColor: "#3f3f3f"
            scrollBarBackgroundColor_hovered: "#4a4a4a"
        }
        ListElement {
            name: "Pink"
            themeColor: "#faa0c5"
            backgroundColor: "#ffffff"
            textColor: "#5c5c5c"

            splitLineColor:"#fbb8d0"
            invalidColor: "#e29696"
            alterColor: "#8a8a9b"
            tipBackgroundColor: "#ffffff"
            tipBorderColor: "#767676"

            textColor_disabled: "#9f9fcf"
            textColor_hovered: "#181818"
            textColor_pressed: "#000000"
            controlColor: "#f5f5f6"
            controlBorderColor: "#cbcbcb"
            imageColor: "#373737"
            imageColor_disabled: "#9f9fcf"
            scrollBarBackgroundColor: "#e0e0e0"
            scrollBarBackgroundColor_hovered: "#cfcfd1"
        }
        ListElement {
            name: "Gold"
            themeColor: "#fed98f"
            backgroundColor: "#ffffff"
            textColor: "#5c5c5c"

            splitLineColor:"#f0c896"
            invalidColor: "#e29696"
            alterColor: "#8a8a9b"
            tipBackgroundColor: "#ffffff"
            tipBorderColor: "#767676"

            textColor_disabled: "#9f9fcf"
            textColor_hovered: "#181818"
            textColor_pressed: "#000000"
            controlColor: "#f5f5f6"
            controlBorderColor: "#cbcbcb"
            imageColor: "#373737"
            imageColor_disabled: "#9f9fcf"
            scrollBarBackgroundColor: "#e0e0e0"
            scrollBarBackgroundColor_hovered: "#cfcfd1"
        }
        ListElement {
            name: "Green"
            themeColor: "#58c979"
            backgroundColor: "#ffffff"
            textColor: "#5c5c5c"

            splitLineColor:"#89d3ad"
            invalidColor: "#e29696"
            alterColor: "#8a8a9b"
            tipBackgroundColor: "#ffffff"
            tipBorderColor: "#767676"

            textColor_disabled: "#9f9fcf"
            textColor_hovered: "#181818"
            textColor_pressed: "#000000"
            controlColor: "#f5f5f6"
            controlBorderColor: "#cbcbcb"
            imageColor: "#373737"
            imageColor_disabled: "#9f9fcf"
            scrollBarBackgroundColor: "#e0e0e0"
            scrollBarBackgroundColor_hovered: "#cfcfd1"
        }
        ListElement {
            name: "Blue"
            themeColor: "#67c1fd"
            backgroundColor: "#ffffff"
            textColor: "#5c5c5c"

            splitLineColor:"#92cefc"
            invalidColor: "#e29696"
            alterColor: "#8a8a9b"
            tipBackgroundColor: "#ffffff"
            tipBorderColor: "#767676"

            textColor_disabled: "#9f9fcf"
            textColor_hovered: "#181818"
            textColor_pressed: "#000000"
            controlColor: "#f5f5f6"
            controlBorderColor: "#cbcbcb"
            imageColor: "#373737"
            imageColor_disabled: "#9f9fcf"
            scrollBarBackgroundColor: "#e0e0e0"
            scrollBarBackgroundColor_hovered: "#cfcfd1"
        }
    }
}
