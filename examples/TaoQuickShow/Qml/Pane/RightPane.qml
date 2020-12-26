import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0
Loader {
    id: rootLoader
    property string homeUrl: qmlPath + "Page/Home.qml"

    source: homeUrl
    clip: true
    Column {
        spacing: 10
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        CusButton_ImageColorOverlay {
            objectName: "wizardBtn"
            width: 32
            height: 32
            visible: rootLoader.item && typeof (rootLoader.item.wizardModel) !== "undefined" && rootLoader.item.wizardModel.count > 0
            btnImgNormal: imgPath + "Common/wizard.png"
            tipText: qsTr("Wizard") + trans.transString
            onClicked: {
                var pRoot = rootLoader
                while (pRoot.parent !== null) {
                    pRoot = pRoot.parent
                }
                wizardComp.createObject(pRoot, {model: rootLoader.item.wizardModel })
            }
        }
        CusButton_ImageColorOverlay {
            width: 32
            height: 32
            visible: isDebug && source && source != homeUrl
            btnImgNormal: imgPath + "Common/view.png"
            tipText: qsTr("View Source Code") + trans.transString
            onClicked: {
                Qt.openUrlExternally(source)
            }
        }
    }
    Component {
        id: wizardComp
        CusWizard {
            id: cusWizard
            anchors.fill: parent
            currentIndex: 0
            onWizardFinished: {
                destroy(cusWizard)
            }
        }
    }
}
