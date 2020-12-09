import QtQuick 2.10
import QtQuick.Controls 2.2
import ".."
import "../.."

RadioButton {
    id: cusRadioButton

    implicitHeight: Config.fixedHeight
    implicitWidth: 200
    property alias tipText: toolTip.text
    property alias tipItem: toolTip
    property alias tipVisible: toolTip.visible
    property alias tipDelay: toolTip.delay
    property alias tipTimeout: toolTip.timeout

    property string btnImgNormal: Config.imagePathPrefix + "0_Common/RadioBtn.png"
    property string btnImgHovered: Config.imagePathPrefix + "0_Common/RadioBtn_Hover.png"
    property string btnImgPressed: Config.imagePathPrefix + "0_Common/RadioBtn_Checked.png"
    property string btnImgDisbaled: Config.imagePathPrefix + "0_Common/RadioBtn_Disabled.png"

    property string btnImgUr: {
        if (!cusRadioButton.enabled) {
            return btnImgDisbaled
        } else if (cusRadioButton.checked || cusRadioButton.pressed) {
            return btnImgPressed
        } else if (cusRadioButton.hovered) {
            return btnImgHovered
        } else {
            return btnImgNormal
        }
    }

    property color textColor: Config.textColor

    indicator: CusImage {
        x: cusRadioButton.leftPadding
        source: btnImgUr
        y: (cusRadioButton.height - height) /2
    }

    contentItem: BasicText {
        height: cusRadioButton.height
        leftPadding: cusRadioButton.leftPadding + cusRadioButton.indicator.width + cusRadioButton.spacing
        text: cusRadioButton.text
        color: cusRadioButton.textColor
        horizontalAlignment: Text.AlignLeft
    }
    BasicTooltip {
        id: toolTip
        visible: cusRadioButton.hovered && String(text).length
    }
    TransArea {}
}
