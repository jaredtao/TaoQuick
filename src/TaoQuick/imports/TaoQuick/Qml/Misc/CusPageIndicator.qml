import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
PageIndicator {
    id: control
    implicitHeight: CusConfig.fixedHeight
    delegate: Rectangle {
        implicitWidth: 40
        implicitHeight: control.height
        color: area.containsMouse ? CusConfig.controlBorderColor_hovered : (index === control.currentIndex ? CusConfig.controlColor_pressed : CusConfig.controlBorderColor)
        CusLabel {
            anchors.centerIn: parent
            text: index
        }
        MouseArea {
            id: area
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                control.currentIndex = index
            }
        }
    }

}
