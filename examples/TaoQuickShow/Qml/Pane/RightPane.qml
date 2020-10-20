import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0
Loader {
    property string homeUrl: "../Page/Home.qml"

    source: homeUrl

    CusButton_ImageColorOverlay {
        anchors {
            right: parent.right
            bottom: parent.bottom
        }
        width: 32
        height: 32
        visible: isDebug && source && source != homeUrl
        btnImgNormal: imgPath + "Common/view.png"
        tipText: qsTr("View Source Code")
        onClicked: {
            Qt.openUrlExternally(source)
        }
    }
}
