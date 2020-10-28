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
    }
    Component {
        id: wizardComp
        CusWizard {
            id: wizard
            anchors.fill: parent
            currentIndex: 0
            count: 5
            totlaString: qsTr("Wizard %1/%2 >").arg(currentIndex + 1).arg(count) + trans.transString
            onWizardFinished: {
                destroy(wizard)
            }
            CusWizardPage {
                visible: wizard.currentIndex === 0
                wizardText: qsTr("Control Buttons for control mainWindow") + trans.transString
                readonly property int controlButtonsWidth: 24 * 4 + 20 * 3
                focusRect: Qt.rect(wizard.parent.width - controlButtonsWidth, 0, controlButtonsWidth, 60)
                pageType: pageTypeUp
            }
            CusWizardPage {
                visible: wizard.currentIndex === 1
                readonly property int skinBtnx: 24 * 8 + 20 * 7
                wizardText: qsTr("Skin Button for change theme") + trans.transString
                focusRect: Qt.rect(wizard.parent.width - skinBtnx, 3, 30, 30)
                pageType: pageTypeUp
            }
            CusWizardPage {
                visible: wizard.currentIndex === 2
                wizardText: qsTr("middle rect for control") + trans.transString
                focusRect: Qt.rect(200,200, 200, 200)
                pageType: pageTypeUp
            }
            CusWizardPage {
                visible: wizard.currentIndex === 3
                wizardText: qsTr("middle rect for control") + trans.transString
                focusRect: Qt.rect(200,200, 200, 200)
                pageType: pageTypeRight
            }
            CusWizardPage {
                visible: wizard.currentIndex === 4
                wizardText: qsTr("middle rect for control") + trans.transString
                focusRect: Qt.rect(200,200, 200, 200)
                pageType: pageTypeDown
            }
        }
    }
}
