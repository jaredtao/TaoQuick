import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

Item {

    signal wizardFinished()
    property string totlaString: qsTr("Wizard %1/%2 >").arg(currentIndex + 1).arg(count)
    property string operatorString: qsTr("Click any area to show next")
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
        z: 999
        id: centerLabel
        anchors.centerIn: parent
        text: totlaString
        font.pixelSize: 22
        color: "white"
    }
    CusLabel {
        z: 999
        anchors.centerIn: parent
        anchors.verticalCenterOffset: centerLabel.height
        text: operatorString
        color: "white"
    }
}
