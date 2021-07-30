import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

CusResizeBorder {
    id: cusBorder
    x: 0
    y: 0
    width: parent.width
    height: parent.height
    readonly property int borderMargin: 6
    readonly property int rotateHandleDistance: 25
    property var controller: parent
    property alias dragEnabled: dragItem.enabled
    property bool rotationEnabled: true

    property color rotateHandleColor: "lightgreen"
    property color color: CusConfig.themeColor
    property color borderColor: CusConfig.controlBorderColor
    signal clicked(real x, real y)
    signal doubleClicked(real x, real y)

    //big
    Rectangle {
        border.color: cusBorder.borderColor
        border.width: 1
        color: cusBorder.color
        radius: borderMargin
        anchors.fill: parent
        anchors.margins: borderMargin + 1
    }
    //line to rotateHandle and Border
    Rectangle {
        color: rotateHandleColor
        width: 2
        visible: rotationEnabled
        height: rotateHandleDistance
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: -rotateHandleDistance
        }
    }
    //top
    Rectangle {
        border.color: CusConfig.controlBorderColor
        border.width: 1
        color: CusConfig.backgroundColor
        width: borderMargin * 2
        height: width
        radius: width / 2
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
    }
    //bottom
    Rectangle {
        border.color: CusConfig.controlBorderColor
        border.width: 1
        color: CusConfig.backgroundColor
        width: borderMargin * 2
        height: width
        radius: width / 2
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }
    //left
    Rectangle {
        border.color: CusConfig.controlBorderColor
        border.width: 1
        color: CusConfig.backgroundColor
        width: borderMargin * 2
        height: width
        radius: width / 2
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
    }
    //right
    Rectangle {
        border.color: CusConfig.controlBorderColor
        border.width: 1
        color: CusConfig.backgroundColor
        width: borderMargin * 2
        height: width
        radius: width / 2
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
    }
    //top left
    Rectangle {
        border.color: CusConfig.controlBorderColor
        border.width: 1
        color: CusConfig.backgroundColor
        width: borderMargin * 2
        height: width
        radius: width / 2
        anchors {
            top: parent.top
            left: parent.left
        }
    }
    Rectangle {
        border.color: CusConfig.controlBorderColor
        border.width: 1
        color: CusConfig.backgroundColor
        width: borderMargin * 2
        height: width
        radius: width / 2
        anchors {
            top: parent.top
            right: parent.right
        }
    }
    Rectangle {
        border.color: CusConfig.controlBorderColor
        border.width: 1
        color: CusConfig.backgroundColor
        width: borderMargin * 2
        height: width
        radius: width / 2
        anchors {
            left: parent.left
            bottom: parent.bottom
        }
    }
    Rectangle {
        border.color: CusConfig.controlBorderColor
        border.width: 1
        color: CusConfig.backgroundColor
        width: borderMargin * 2
        height: width
        radius: width / 2
        anchors {
            right: parent.right
            bottom: parent.bottom
        }
    }

    Rectangle {
        color: rotateHandleColor
        width: borderMargin * 2
        height: width
        radius: width / 2
        visible: rotationEnabled
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: -rotateHandleDistance
        }
        CusImage {
            id: rotateCursor
            source: CusConfig.imagePathPrefix + "rotate.png"
            visible: rotateArea.containsMouse | rotateArea.pressed
            x: rotateArea.mouseX - width / 2
            y: rotateArea.mouseY - height / 2
        }
        MouseArea {
            id: rotateArea
            anchors.centerIn: parent
            width: parent.width * 2
            height: parent.height * 2
            hoverEnabled: true
            property int lastX: 0
            onContainsMouseChanged: {
                if (containsMouse) {
                    cursorShape = Qt.BlankCursor
                } else {
                    cursorShape = Qt.ArrowCursor
                }
            }
            onPressedChanged: {
                if (containsPress) {
                    lastX = mouseX
                }
            }
            onPositionChanged: {
                if (pressed) {
                    var t = controller.rotation + (mouseX - lastX) / 5
                    t = t % 360
                    controller.rotation = t
                }
            }
        }
        BasicTooltip {
            id: toolTip
            x: rotateArea.mouseX + 30
            y: rotateArea.mouseY
            visible: rotateArea.pressed
            text: parseInt(controller.rotation) + "°"
        }
    }
    MouseArea {
        id: dragItem
        anchors.fill: parent
        anchors.margins: borderMargin * 2
        cursorShape: Qt.PointingHandCursor
        drag.target: controller
        onClicked: {
            cusBorder.clicked(x, y)
        }
        onDoubleClicked: {
            cusBorder.doubleClicked(x, y)
        }
    }
}
