import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

Item {
    id: cusWizardItem
    signal wizardFinished
    property string totlaString: qsTr("Wizard %1/%2 >").arg(currentIndex + 1).arg(count) + CusConfig.transString
    property string operatorString: qsTr("Click any area to show next") + CusConfig.transString
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
    property var model
    property int count: model.count
    property int currentIndex: 0
    Repeater {
        model: cusWizardItem.model
        delegate: CusWizardPage {
            anchors.fill: parent
            visible: index === currentIndex
            wizardName: model.name
            wizardDescript: model.descript
            targetObjectName: model.targetObjectName
            pageType: model.arrowType
        }
    }
    CusLabel {
        z: 999
        id: centerLabel
        anchors {
            centerIn: parent
            horizontalCenterOffset: 300
            verticalCenterOffset: 150
        }
        text: totlaString
        font.pixelSize: 22
        color: "white"
    }
    CusLabel {
        z: 999
        anchors {
            centerIn: parent
            horizontalCenterOffset: 300
            verticalCenterOffset: 150 + centerLabel.height
        }
        text: operatorString
        color: "white"
    }
}
