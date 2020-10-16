import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import ".."
import "../.."

CheckBox {
    id: cusCheckBox
    height: CusConfig.fixedHeight

    //    background: Rectangle  {
    //        color: cusCheckBox.enabled ? Config.controlBackgroundColor : Config.controlBackgroundColor_disabled
    //        radius: Config.controlBorderRadius
    //        border.width: 1
    //        border.color: cusCheckBox.hovered ? Config.controlBorderColor_hovered : Config.controlBorderColor
    //    }
    checked: false
    contentItem: CusLabel {
        leftPadding: cusCheckBox.indicator.width + cusCheckBox.spacing
        text: cusCheckBox.text
        font: cusCheckBox.font
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        color: cusCheckBox.enabled ? CusConfig.textColor : CusConfig.textColor_disabled
    }
    property color colorNormal: CusConfig.imageColor
    property color colorHovered: CusConfig.imageColor_hovered
    property color colorPressed: CusConfig.imageColor_pressed
    property color colorDisable: CusConfig.imageColor_disabled
//    readonly property string imgUrlNormal: CusConfig.imagePathPrefix + "Checkbox_16.png"
//    readonly property string imgUrlChecked: CusConfig.imagePathPrefix + "Checkbox_16_Checked.png"
//    readonly property string imgUrlHovered: CusConfig.imagePathPrefix + "Checkbox_16_Hover.png"
//    readonly property string imgUrlDisable: CusConfig.imagePathPrefix + "Checkbox_16_Disable.png"
//    readonly property string imgUrlCheckedDisable: CusConfig.imagePathPrefix + "Checkbox_16_Checked_Disable.png"
    readonly property string imgUrlBorder: CusConfig.imagePathPrefix + "checkbox_border.png"
    readonly property string imgUrlCheck: CusConfig.imagePathPrefix + "checkbox_check.png"


    CusImage {
        id: baseImgCheck
        smooth: true
        visible: false
        source: imgUrlCheck
    }
    CusImage {
        id: baseImgBorder
        smooth: true
        visible: false
        source: imgUrlBorder
    }

    indicator: ColorOverlay {
        id: indicatorImg
        x: cusCheckBox.leftPadding
        y: cusCheckBox.height / 2 - height / 2
        source: baseImgBorder
        width: baseImgBorder.width
        height: baseImgBorder.height
        cached: true
        color: {
            if (!cusCheckBox.enabled) {
                return colorDisable
            } else if (cusCheckBox.pressed) {
                return colorPressed
            } else if (cusCheckBox.hovered) {
                return colorHovered
            } else {
                return colorNormal
            }
        }
        ColorOverlay {
            anchors.fill: parent
            anchors.margins: 2
            source: baseImgCheck
            visible: cusCheckBox.checked
            cached: true
            color: {
                if (!cusCheckBox.enabled) {
                    return colorDisable
                } else if (cusCheckBox.pressed) {
                    return colorPressed
                } else if (cusCheckBox.hovered) {
                    return colorHovered
                } else {
                    return colorNormal
                }
            }
        }
    }
    TransArea {
        enabled: cusCheckBox.enabled
    }
}
