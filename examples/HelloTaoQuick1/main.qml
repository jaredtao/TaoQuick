import QtQml 2.0
import QtQuick 2.9

import QtQuick.Controls 2.0

import TaoQuick 1.0

Rectangle {
    color: "lightblue"
    width: 640
    height: 480
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
