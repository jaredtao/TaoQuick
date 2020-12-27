import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0
import "../Biz"

Rectangle {
    color: CusConfig.themeColor
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
            color: "#ffffff"
        }
    }
    property bool isMaxed: view.isMax
    Row {
        id: controlButtons
        objectName: "controlButtonsRow"
        height: 24
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 20
        spacing: 20
        CusButton_Image {
            width: 24
            height: 24
            btnImgUrl: imgPath + (hovered || pressed ? "Window/minimal_white.png" : "Window/minimal_gray.png")
            tipText: qsTr("minimal") + trans.transString
            onClicked: {
                view.showMinimized()
            }
        }
        CusButton_Image {
            width: 24
            height: 24
            visible: !isMaxed
            btnImgUrl: imgPath + (hovered || pressed ? "Window/max_white.png" : "Window/max_gray.png")
            tipText: qsTr("maximize") + trans.transString
            onClicked: {
                view.showMaximized()
            }
        }
        CusButton_Image {
            width: 24
            height: 24
            visible: isMaxed
            btnImgUrl: imgPath
                       + (hovered || pressed ? "Window/normal_white.png" : "Window/normal_gray.png")
            tipText: qsTr("normal") + trans.transString
            onClicked: {
                view.showNormal()
            }
        }
        CloseBtn {
            width: 24
            height: 24
            onClicked: {
                view.close()
            }
        }
    }
    Rectangle {
        id: splitLine
        height: parent.height * 0.4
        width: 1
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: controlButtons.left
        anchors.rightMargin: 10
        color: CusConfig.splitLineColor
    }
    Row {
        id: toolRow

        height: 24
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: splitLine.left
        anchors.rightMargin: 20
        spacing: 20
        SkinBtn {
            width: 24
            height: 24
            anchors.verticalCenter: parent.verticalCenter
            objectName: "skinBtn"
        }
        LangBtn {
            width: 24
            height: 24
            anchors.verticalCenter: parent.verticalCenter
            objectName: "langBtn"
        }
        CusButton_Image {
            width: 24
            height: 24
            anchors.verticalCenter: parent.verticalCenter
            tipText: qsTr("Settings") + trans.transString
            btnImgUrl: imgPath
                       + (hovered || pressed ? "Window/settings_white.png" : "Window/settings_gray.png")
            onClicked: {
                settingDialog.show()
            }
        }
        CusButton_Image {
            width: 24
            height: 24
            anchors.verticalCenter: parent.verticalCenter
            tipText: qsTr("About") + trans.transString
            btnImgUrl: imgPath
                       + (hovered || pressed ? "Window/about_white.png" : "Window/about_gray.png")
            onClicked: {
                aboutDialog.show()
            }
        }
    }
    property alias blankItem: blankItem
    Item {
        id: blankItem
        objectName: "blankItem"
        anchors {
            left: parent.left
            leftMargin: 4
            right: toolRow.left
            top: parent.top
            topMargin: 4
            bottom: parent.bottom
        }
        Component.onCompleted: {
            view.setTitleItem(blankItem)
        }
        MoveArea {
            anchors.fill: parent
            onMove: {
                view.x += xOffset
                view.y += yOffset
            }
        }
    }
}
