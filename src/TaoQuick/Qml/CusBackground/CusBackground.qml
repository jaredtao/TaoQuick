import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

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
