import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick 2.9
import TaoQuick 1.0
Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    CusButton_Blue {
        width: 120
        height: 36
        anchors.centerIn: parent
        text: "Hello"
        onClicked: {
            console.log("hello TaoQuick")
        }
    }
}
