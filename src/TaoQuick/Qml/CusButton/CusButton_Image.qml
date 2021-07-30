import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

Button {
    id: cusButtonImage
    implicitWidth: 24
    implicitHeight: 24

    property alias tipText: toolTip.text
    property alias tipItem: toolTip
    property alias tipVisible: toolTip.visible
    property alias tipDelay: toolTip.delay
    property alias tipTimeout: toolTip.timeout
    property bool selected: false
    property string btnImgNormal
    property string btnImgHovered
    property string btnImgPressed
    property string btnImgDisbaled

    property string btnImgUrl: {
        if (!cusButtonImage.enabled) {
            return btnImgDisbaled
        } else if (cusButtonImage.pressed || selected) {
            return btnImgPressed
        } else if (cusButtonImage.hovered) {
            return btnImgHovered
        } else {
            return btnImgNormal
        }
    }
    background: Item {
        width: cusButtonImage.width
        height: cusButtonImage.height
        CusImage {
            id: backImage
            source: btnImgUrl
            anchors.centerIn: parent
        }
    }
    BasicTooltip {
        id: toolTip
        visible: cusButtonImage.hovered && String(text).length
        delay: 500
    }
    TransArea {
    }
}
