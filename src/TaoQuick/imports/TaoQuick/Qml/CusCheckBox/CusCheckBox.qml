import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

CheckBox {
    id: cusCheckBox
    height: Config.fixedHeight

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
        color: cusCheckBox.enabled ? Config.textColor : Config.controlTextColor_disable
    }
    indicator: Image {
        x: cusCheckBox.leftPadding
        y: cusCheckBox.height / 2 - height / 2
        width: sourceSize.width
        height: sourceSize.height

        readonly property string imgUrlNormal: Config.imagePathPrefix + "0_Common/Checkbox_16.png"
        readonly property string imgUrlChecked: Config.imagePathPrefix
                                                + "0_Common/Checkbox_16_Checked.png"
        readonly property string imgUrlHovered: Config.imagePathPrefix
                                                + "0_Common/Checkbox_16_Hover.png"
        readonly property string imgUrlDisable: Config.imagePathPrefix
                                                + "0_Common/Checkbox_16_Disable.png"
        readonly property string imgUrlCheckedDisable: Config.imagePathPrefix
                                                       + "0_Common/Checkbox_16_Checked_Disable.png"

        source: cusCheckBox.enabled ? (cusCheckBox.checked ? imgUrlChecked : (cusCheckBox.hovered ? imgUrlHovered : imgUrlNormal)) : (cusCheckBox.checked ? imgUrlCheckedDisable : imgUrlDisable)
    }
    TransArea {
        enabled: cusCheckBox.enabled
    }
}
