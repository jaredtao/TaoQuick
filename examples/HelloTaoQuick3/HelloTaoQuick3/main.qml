import QtQuick 2.9
import QtQuick.Window 2.2
import TaoQuick 1.0
Window {
    visible: true
    width: 640
    height: 480
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
