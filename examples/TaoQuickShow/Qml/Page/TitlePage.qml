import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0
import "./Biz"
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
        height: 32
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 20
        spacing: 20
        CusButton_Image {
            btnImgUrl: imgPath + (containsMouse ? "Window/minimal_white.png" : "Window/minimal_gray.png")
            onClicked: {
                view.showMinimized()
            }
        }
        CusButton_Image {
            visible: !isMaxed
            btnImgUrl: imgPath + (containsMouse ? "Window/max_white.png" : "Window/max_gray.png")
            onClicked: {
                view.showMaximized()
            }
        }
        CusButton_Image {
            visible: isMaxed
            btnImgUrl: imgPath + (containsMouse ? "Window/normal_white.png" : "Window/normal_gray.png")
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
        height: parent.height * 0.6
        width: 1
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: controlButtons.left
        anchors.rightMargin: 10
    }
    Row {
        id: toolRow
        height: 32
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: splitLine.left
        anchors.rightMargin: 20
        spacing: 20
        SkinBtn {
            anchors.verticalCenter: parent.verticalCenter
        }
        LangBtn {
            anchors.verticalCenter: parent.verticalCenter
        }
        CusButton_Image {
            anchors.verticalCenter: parent.verticalCenter

            btnImgUrl: imgPath + (containsMouse ? "Window/about_white.png" : "Window/about_gray.png")
            onClicked: {
                aboutDialog.show()
            }
        }
    }
    property alias blankItem: blankItem
    Item {
        id: blankItem
        anchors {
            left: parent.left
            right: toolRow.left
            top: parent.top
            bottom: parent.bottom
        }
        Component.onCompleted: {
            view.setTitleItem(blankItem)
        }
    }
}
