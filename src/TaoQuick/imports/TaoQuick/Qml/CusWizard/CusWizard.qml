import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

Item {
    signal wizardFinished()
    property string totlaString: qsTr("Wizard %1/%2 >").arg(currentIndex + 1).arg(count)
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            currentIndex++
            if (currentIndex >= count) {
                wizardFinished()
            }
        }
    }
    property int count: 0
    property int currentIndex: 0
    CusLabel {
        z: 3
        anchors.centerIn: parent
        text: totlaString
        font.pixelSize: 20
        color: "white"
    }
}
