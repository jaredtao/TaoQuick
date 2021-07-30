import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
Rectangle {
    color: CusConfig.backgroundColor
    MouseArea {
        id: backgroundArea
        anchors.fill: parent
        onClicked: {
            focus = true
        }
    }
}
