import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import ".."
import "../.."

Button {
    id: cusButtonImage
    implicitWidth: baseImage.width
    implicitHeight: baseImage.height

    property alias tipText: toolTip.text
    property alias tipItem: toolTip
    property alias tipVisible: toolTip.visible
    property alias tipDelay: toolTip.delay
    property alias tipTimeout: toolTip.timeout

    property string btnImgNormal
    property string btnImgHovered
    property string btnImgPressed
    property string btnImgDisbaled

    property string btnImgUrl: {
        if (!cusButtonImage.enabled) {
            return btnImgDisbaled
        } else if (cusButtonImage.pressed) {
            return btnImgPressed
        } else if (cusButtonImage.hovered || cusButtonImage.focus) {
            return btnImgHovered
        } else {
            return btnImgNormal
        }
    }
    //    background: CusImage {
    //        id: backImage
    //        source: btnImgUrl
    //    }
    property color colorNormal: CusConfig.imageColor
    property color colorHovered: CusConfig.imageColor_hovered
    property color colorPressed: CusConfig.imageColor_pressed
    property color colorDisable: CusConfig.imageColor_disabled
    CusImage {
        id: baseImage
        source: btnImgNormal
        smooth: true
        visible: false
    }
    background: ColorOverlay {
        source: baseImage
        cached: true
        color: {
            if (!cusButtonImage.enabled) {
                return colorDisable
            } else if (cusButtonImage.pressed) {
                return colorPressed
            } else if (cusButtonImage.hovered) {
                return colorHovered
            } else {
                return colorNormal
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
