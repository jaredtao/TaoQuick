import QtQuick 2.10
import QtQuick.Controls 2.2
import ".."
import "../.."
Button {
    id: cusButtonImage

    property alias tipText: toolTip.text
    property alias tipItem: toolTip
    property alias tipVisible: toolTip.visible
    property alias tipDelay: toolTip.delay
    property alias tipTimeout: toolTip.timeout

    property string btnImgUr
    property color backgroundColor: "transparent"
    property color backgroundColor_pressed
    property color backgroundColor_hovered

    BasicTooltip {
        id: toolTip
        visible: cusButtonImage.hovered && String(text).length
    }
    background: Rectangle {
        width: cusButtonImage.width
        height: cusButtonImage.height
        color: cusButtonImage.pressed ? backgroundColor_pressed : ( cusButtonImage.hovered ? backgroundColor_hovered : backgroundColor)
        CusImage {
            anchors.centerIn: parent
            width: cusButtonImage.width
            height: cusButtonImage.height
            source: btnImgUr
        }
    }
    TransArea {}
}
