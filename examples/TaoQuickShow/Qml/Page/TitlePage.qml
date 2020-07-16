import QtQuick 2.12
import QtQuick.Controls 2.12
import TaoQuick 1.0
import "qrc:/TaoQuick"
import "Biz"
Rectangle {
    Row {
        anchors.left: parent.left
        height: parent.height
        spacing: 4
        Image {
            source: imgPath + "logo/milk.png"
        }
        Text {
            id: t
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 28
            font.bold: true
            text: "TaoQuick"
        }
    }
    property bool isMaxed: view.isMax
    Row {
        id: controlButtons
        height: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 12
        spacing: 10
        TImageBtn {
            width: 20
            height: 20
            imageUrl: imgPath + (containsMouse ? "Window/minimal_white.png" : "Window/minimal_gray.png")
            onClicked: {
                view.showMinimized()
            }
        }
        TImageBtn {
            width: 20
            height: 20
            visible: !isMaxed
            imageUrl: imgPath + (containsMouse ? "Window/max_white.png" : "Window/max_gray.png")
            onClicked: {
                view.showMaximized()
            }
        }
        TImageBtn {
            width: 20
            height: 20
            visible: isMaxed
            imageUrl: imgPath + (containsMouse ? "Window/normal_white.png" : "Window/normal_gray.png")
            onClicked: {
                view.showNormal()
            }
        }
        CloseBtn {
            onClicked: {
                view.close()
            }
        }
    }
    Rectangle {
        id: splitLine
        height: 16
        width: 1
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: controlButtons.left
        anchors.rightMargin: 10
    }
    Row {
        height: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: splitLine.left
        anchors.rightMargin: 10
        spacing: 10
        SkinBtn {
            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter
        }
        LangBtn {
            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter
        }
        TImageBtn {
            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter

            imageUrl: imgPath + (containsMouse ? "Window/about_white.png" : "Window/about_gray.png")
            onClicked: {
                aboutDialog.show()
            }
        }
    }
}
