import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

Button {
    id: cusButton
    height: CusConfig.fixedHeight

    property alias tipText: toolTip.text
    property alias tipItem: toolTip
    property alias tipVisible: toolTip.visible
    property alias tipDelay: toolTip.delay
    property alias tipTimeout: toolTip.timeout

    property color backgroundColorNormal: CusConfig.controlColor
    property color backgroundColorHovered: CusConfig.controlColor_hovered
    property color backgroundColorPressed: CusConfig.controlColor_pressed
    property color backgroundColorDisable: CusConfig.controlColor_disabled
    property bool selected: false
    property color borderColor: {
        if (!cusButton.enabled) {
            return CusConfig.controlBorderColor_disabled
        } else if (cusButton.pressed || selected) {
            return CusConfig.controlBorderColor_pressed
        } else if (cusButton.hovered) {
            return CusConfig.controlBorderColor_hovered
        } else {
            return CusConfig.controlBorderColor
        }
    }
    property int borderWidth: 1
    property int radius: CusConfig.controlBorderRadius
    property color textColor: {
        if (!cusButton.enabled) {
            return CusConfig.textColor_disabled
        } else if (cusButton.pressed || selected) {
            return CusConfig.textColor_pressed
        } else if (cusButton.hovered) {
            return CusConfig.textColor_hovered
        } else {
            return CusConfig.textColor
        }
    }
    property color backgroundColor: {
        if (!cusButton.enabled) {
            return backgroundColorDisable
        } else if (cusButton.pressed || selected) {
            return backgroundColorPressed
        } else if (cusButton.hovered) {
            return backgroundColorHovered
        } else {
            return backgroundColorNormal
        }
    }

    BasicTooltip {
        id: toolTip
        visible: cusButton.hovered && String(text).length
        delay: 500
    }
    contentItem: BasicText {
        text: cusButton.text
        color: cusButton.textColor
    }
    background: Rectangle {
        radius: cusButton.radius
        color: cusButton.backgroundColor
        border.color: cusButton.borderColor
        border.width: cusButton.borderWidth
    }
    TransArea {
    }
}
