import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0
Loader {
    id: rootLoader
    property string homeUrl: qmlPath + "Page/Home.qml"

    source: homeUrl

    Column {
        spacing: 10
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        CusButton_ImageColorOverlay {
            width: 32
            height: 32
            visible: rootLoader.item && typeof rootLoader.item.hasWizard !== "undefined" && rootLoader.item.hasWizard === true
            btnImgNormal: imgPath + "Common/wizard.png"
            tipText: qsTr("Wizard") + trans.transString
            onClicked: {
                rootLoader.item.showWizard()
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

}
