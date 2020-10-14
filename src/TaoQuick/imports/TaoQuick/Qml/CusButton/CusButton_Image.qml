import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
Button {
    id: cusButtonImage
    implicitWidth: backImage.width
    implicitHeight: backImage.height

    property alias tipText: toolTip.text
    property alias tipItem: toolTip
    property alias tipVisible: toolTip.visible
    property alias tipDelay: toolTip.delay
    property alias tipTimeout: toolTip.timeout
    property bool containsMouse: hovered
    property bool containsPressed: pressed

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


    BasicTooltip {
        id: toolTip
        visible: cusButtonImage.hovered && String(text).length
        delay: 500
    }
    background: Image {
        id: backImage
        source: btnImgUrl
        width: sourceSize.width
        height: sourceSize.height
    }
    TransArea {}
}
