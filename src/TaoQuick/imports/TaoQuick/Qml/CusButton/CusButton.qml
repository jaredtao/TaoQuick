import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
Button {
    id: cusButton
    height: Config.fixedHeight

    property alias tipText: toolTip.text
    property alias tipItem: toolTip
    property alias tipVisible: toolTip.visible
    property alias tipDelay: toolTip.delay
    property alias tipTimeout: toolTip.timeout

    property bool containsMouse: hovered
    property bool containsPress: pressed
    property color backgroundColorNormal
    property color backgroundColorHovered
    property color backgroundColorPressed
    property color backgroundColorDisable
    property color borderColor
    property int borderWidth: (enabled && focus) ? 1 : 0
    property int radius: 4
    property color textColor
    property color backgroundColor: {
        if (!cusButton.enabled) {
            return backgroundColorDisable
        } else if (cusButton.pressed) {
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
    TransArea {}
}
