import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0
Item {
    id: homeItem
    anchors.centerIn: parent
    CusLabel {
        text: qsTr("TaoQuick provides a set of controls that can be used to build complete interfaces in Qt Quick.") + trans.transString
        horizontalAlignment: Label.AlignHCenter
        verticalAlignment: Label.AlignVCenter
        wrapMode: Label.Wrap
        anchors.centerIn: parent
    }
    property bool hasWizard: true
    function showWizard() {
        var pRoot = homeItem
        while (pRoot.parent !== null) {
            pRoot = pRoot.parent
        }
        wizardComp.createObject(pRoot)
//        wizardComp.createObject(pRoot, {x: pRoot.x, y: pRoot.y, width: pRoot.width, height: pRoot.height})
    }
    Component {
        id: wizardComp
        CusWizard {
            id: wizard
            anchors.fill: parent
            currentIndex: 0
            count: 2
            onWizardFinished: {
                destroy(wizard)
            }
            CusWizardPage {
                z: 1
                visible: wizard.currentIndex === 0
                wizardText: qsTr("titleRect can control window")
                focusRect: Qt.rect(0,0, wizard.parent.width, 80)
            }
            CusWizardPage {
                z: 1
                visible: wizard.currentIndex === 1
                wizardText: qsTr("middle rect for control")
                focusRect: Qt.rect(200,200, 200, 200)
            }
        }
    }
}
