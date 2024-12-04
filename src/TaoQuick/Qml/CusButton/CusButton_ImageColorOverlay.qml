import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

import ".."
import "../.."

Button {
    id: cusButtonImage
    implicitWidth: 30
    implicitHeight: 30
    property alias tipText: toolTip.text
    property alias tipItem: toolTip
    property alias tipVisible: toolTip.visible
    property alias tipDelay: toolTip.delay
    property alias tipTimeout: toolTip.timeout

    property string btnImgNormal

    property bool selected: false
    property color colorNormal: CusConfig.imageColor
    property color colorHovered: CusConfig.imageColor_hovered
    property color colorPressed: CusConfig.imageColor_pressed
    property color colorDisable: CusConfig.imageColor_disabled

    property color backgroundColor: "transparent"
    CusImage {
        id: baseImage
        source: btnImgNormal
        smooth: true
        visible: false
    }
    background: Rectangle {
        width: cusButtonImage.width
        height: cusButtonImage.height
        radius: CusConfig.controlBorderRadius
        color: backgroundColor
        CusColorOverlay {
            source: baseImage
            width: baseImage.width
            height: baseImage.height
            anchors.centerIn: parent
            imageColor: {
                if (!cusButtonImage.enabled) {
                    return colorDisable
                } else if (cusButtonImage.pressed || selected) {
                    return colorPressed
                } else if (cusButtonImage.hovered) {
                    return colorHovered
                } else {
                    return colorNormal
                }
            }
        }
    }
    BasicTooltip {
        id: toolTip
        visible: cusButtonImage.hovered && String(text).length
        delay: 500
    }
    TransArea {}
}
