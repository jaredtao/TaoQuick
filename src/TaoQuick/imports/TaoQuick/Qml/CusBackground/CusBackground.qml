import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
Rectangle {
    color: Config.backgroundColor0
    MouseArea {
        id: backgroundArea
        anchors.fill: parent
        onClicked: {
            focus = true
        }
    }
}
