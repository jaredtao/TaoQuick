import QtQml 2.2
import QtQuick 2.9

QtObject {
    property string themeName
    property color themeColor: "#c62f2f"

    property color backgroundColor: "#f6f6f6"

    property color backgroundBorderColor

    property color splitLineColor: "#a82828"

    property color textColor: "#5c5c5c"
    property color textColor_disabled
    property color textColor_highlighted
    property color textColor_hovered

    property color controlInvalidColor
    property color controlBackgroundColor
    property color controlBackgroundColor_selected
    property color controlBackgroundColor_disabled
    property color controlBackgroundColor_highlighted
    property color controlBackgroundColor_hovered
    property color controlBorderColor
    property color controlBorderColor_hovered

    property color alterColor

    property color scrollBarBackgroundColor

    property color tipBackgroundColor
    property color tipBorderColor
    property color tipTextColor
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
    function changeTo(o) {
        themeName = o.themeName
        themeColor = o.themeColor

        backgroundColor = o.backgroundColor
        backgroundBorderColor = o.backgroundBorderColor

        splitLineColor = o.splitLineColor

        textColor = o.textColor
        textColor_disabled = o.textColor_disabled
        textColor_highlighted = o.textColor_highlighted
        textColor_hovered = o.textColor_hovered

        controlInvalidColor = o.controlInvalidColor
        controlBackgroundColor = o.controlBackgroundColor
        controlBackgroundColor_selected = o.controlBackgroundColor_selected
        controlBackgroundColor_disabled = o.controlBackgroundColor_disabled
        controlBackgroundColor_highlighted = o.controlBackgroundColor_highlighted
        controlBackgroundColor_hovered = o.controlBackgroundColor_hovered
        controlBorderColor = o.controlBorderColor
        controlBorderColor_hovered = o.controlBorderColor_hovered

        alterColor = o.alterColor

        scrollBarBackgroundColor = o.scrollBarBackgroundColor

        tipBackgroundColor = o.tipBackgroundColor
        tipBorderColor = o.tipBorderColor
        tipTextColor = o.tipTextColor
    }
}
