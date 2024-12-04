import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

import TaoQuick

Item {
    anchors.fill: parent
    signal replayClicked
    CusButton {
        anchors {
            left: parent.left
            bottom: parent.bottom
            margins: 10
        }
        text: qsTr("Replay") + trans.transString
        onClicked: {
            replayClicked()
        }
    }
}
