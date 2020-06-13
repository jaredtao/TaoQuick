import QtQuick 2.12
import QtQuick.Controls 2.12
import TaoQuick 1.0
import "qrc:/TaoQuick"
import "Biz"
Background {
    id: root
    Rectangle {
        id: vLine
        width: parent.width - 2
        height: 1
        y: parent.height / 8
        x: 1
        color: gConfig.splitColor
    }
    Rectangle {
        id: hLine
        width: 1
        height: parent.height - 2
        y: 1
        x: parent.width / 4
        color: gConfig.splitColor
    }
    Item {
        id: logoFrame
        anchors {
            left: parent.left
            top: parent.top
            right: hLine.left
            bottom: vLine.top
        }
        Text {
            text: trans.trans("Menu") + trans.transString
            anchors.centerIn: parent
            color: gConfig.textColor
        }
    }
    Item {
        id: titleFrame
        anchors {
            left: hLine.right
            right: parent.right
            top: parent.top
            bottom: vLine.top
        }
        Text {
            id: titleText
            text: trans.trans(menuPage.currentTitle) + trans.transString
            anchors.centerIn: parent
            font.pixelSize: 26
            color: gConfig.titleBackground
        }
        TFPS {
            width: 100
            height: 40
            anchors.right: parent.right
            anchors.top: parent.top
            textColor: gConfig.titleBackground
        }
    }
    Item {
        id: menuFrame
        anchors {
            left: parent.left
            right: hLine.left
            top: vLine.bottom
            bottom: parent.bottom
        }
        MenuPage {
            id: menuPage
            anchors.fill: parent
            model:gConfig.contentData
        }
    }
    Item {
        id: contentFrame
        anchors {
            left: hLine.right
            right: parent.right
            top: vLine.bottom
            bottom: parent.bottom
        }
        clip: true
        Loader {
            id: contentPage
            anchors.fill: parent
            source: menuPage.currentUrl
        }
    }
}
