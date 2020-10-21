import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

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
