import QtQuick 2.9
import QtQuick.Controls 2.2
 import QtGraphicalEffects 1.0
import ".."
import "../.."

Item {
    id: pageItem
    anchors.fill: parent
    property rect focusRect
    property string wizardText

    property color maskColor: "black"
    property real maskOpacity: 0.75
    Item {
        id: focusItem
        x: focusRect.x
        y: focusRect.y
        width: focusRect.width
        height: focusRect.height
        RadialGradient {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 0.8; color: maskColor }
            }
            opacity: maskOpacity
        }
    }
    Row {
        id: leftRow
        spacing: 10
        visible: focusRect.x < 5
        anchors {
            left: focusItem.right
            leftMargin: 5
            verticalCenter: focusItem.verticalCenter
        }
        CusImage {
            source: CusConfig.imagePathPrefix + "arrow-left.png"

            anchors.verticalCenter: parent.verticalCenter
        }
        CusLabel {
            width: 300
            text: wizardText
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    Row {
        id: rightRow
        spacing: 10
        layoutDirection: Qt.RightToLeft
        visible: focusRect.x + focusRect.width > pageItem.width - 5
        anchors {
            right: focusItem.left
            rightMargin: 5
            verticalCenter: focusItem.verticalCenter
        }
        CusImage {
            source: CusConfig.imagePathPrefix + "arrow-right.png"
            anchors.verticalCenter: parent.verticalCenter
        }
        CusLabel {
            width: 300
            text: wizardText
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    Column {
        id: downColumn
        spacing: 10
        visible: !leftRow.visible && !rightRow.visible && focusRect.y > pageItem.height / 2
        anchors {
            bottom: focusItem.top
            bottomMargin: 5
            horizontalCenter: focusItem.horizontalCenter
        }
        CusLabel {
            width: 300
            text: wizardText
            anchors.horizontalCenter: parent.horizontalCenter
        }
        CusImage {
            source: CusConfig.imagePathPrefix + "arrow-down.png"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    Column {
        id: upColumn
        spacing: 10
        visible: !leftRow.visible && !rightRow.visible && !downColumn
        anchors {
            top: focusItem.bottom
            topMargin: 5
            horizontalCenter: focusItem.horizontalCenter
        }
        CusImage {
            source: CusConfig.imagePathPrefix + "arrow-up.png"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        CusLabel {
            width: 300
            text: wizardText
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    //left
    Rectangle {
        x: 0
        y: 0
        width: focusRect.x
        height: parent.height
        color: maskColor
        opacity: maskOpacity
    }
    //right
    Rectangle {
        x: focusRect.x + focusRect.width
        y: 0
        width: pageItem.width - x
        height: parent.height
        color: maskColor
        opacity: maskOpacity
    }
    //top
    Rectangle {
        x: focusRect.x
        width: focusRect.width
        y: 0
        height: focusRect.y
        color: maskColor
        opacity: maskOpacity
    }
    //bottom
    Rectangle {
        x: focusRect.x
        width: focusRect.width
        y: focusRect.y + focusRect.height
        height: pageItem.height - y
        color: maskColor
        opacity: maskOpacity
    }
}
