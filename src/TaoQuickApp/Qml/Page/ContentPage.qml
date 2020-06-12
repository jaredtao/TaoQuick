import QtQuick 2.12
import QtQuick.Controls 2.12
import TaoQuick 1.0
import "qrc:/TaoQuick"

Rectangle {
    id: root
    SequentialAnimation {
        running: s.checked
        loops: Animation.Infinite
        ParallelAnimation {
            PropertyAnimation { target: img1; property: "x"; to: -root.width; duration: 50000}
            PropertyAnimation { target: img2; property: "x"; to: 0; duration: 50000}
        }
        ScriptAction {
            script: { img1.x = root.width}
        }
        ParallelAnimation {
            PropertyAnimation { target: img2; property: "x"; to: -root.width; duration: 50000}
            PropertyAnimation { target: img1; property: "x"; to: 0; duration: 50000}
        }
        ScriptAction {
            script: { img2.x = root.width}
        }
    }
    Switch {
        id: s
        text: "Background"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 40
    }
    Image {
        id: img1
        x: 0
        y: 0
        opacity: 0.2
        width: parent.width
        height: parent.height
        source: "qrc:/Image/Window/flower.jpg"
    }
    Image {
        id: img2
        x: root.width
        y: 0
        opacity: 0.2
        width: parent.width
        height: parent.height
        source: "qrc:/Image/Window/flower.jpg"
    }
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
            text: qsTr("菜单")
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
            text: qsTr(menuPage.currentTitle)
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
