import QtQuick 2.9
import QtQuick.Controls 2.2
// import QtGraphicalEffects 1.0
import ".."
import "../.."

Item {
    id: pageItem
    z: 998
    anchors.fill: parent
    property string wizardName
    property string wizardDescript
    property string targetObjectName
    property int pageType: pageTypeDown

    property color maskColor: "black"
    property real maskOpacity: 0.75

    property rect focusRect

    readonly property int pageTypeDown: Qt.DownArrow
    readonly property int pageTypeUp: Qt.UpArrow
    readonly property int pageTypeLeft: Qt.LeftArrow
    readonly property int pageTypeRight: Qt.RightArrow


    Component.onCompleted: {
        var rect = quickTool.getItemGeometryToScene(targetObjectName)
        focusRect = rect
    }
    Item {
        id: focusItem
        x: focusRect.x
        y: focusRect.y
        width: focusRect.width
        height: focusRect.height
//        RadialGradient {
//            anchors.fill: parent
//            gradient: Gradient {
//                GradientStop { position: 0.0; color: "transparent" }
//                GradientStop { position: 0.6; color: maskColor }
//            }
//            opacity: maskOpacity / 2
//        }
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
    Row {
        id: leftRow
        spacing: 10
        visible: pageType === pageTypeLeft
        z: 998
        anchors {
            left: focusItem.right
            leftMargin: 5
            verticalCenter: focusItem.verticalCenter
        }
        CusImage {
            source: CusConfig.imagePathPrefix + "arrow-left.png"
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    Row {
        id: rightRow
        spacing: 10
        layoutDirection: Qt.RightToLeft
        visible: pageType === pageTypeRight
        z: 998
        anchors {
            right: focusItem.left
            rightMargin: 5
            verticalCenter: focusItem.verticalCenter
        }
        CusImage {
            source: CusConfig.imagePathPrefix + "arrow-right.png"
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    Column {
        id: downColumn
        spacing: 10
        visible: pageType === pageTypeDown
        width: 300
        z: 998
        anchors {
            bottom: focusItem.top
            bottomMargin: 5
            horizontalCenter: focusItem.horizontalCenter
        }
        CusImage {
            source: CusConfig.imagePathPrefix + "arrow-down.png"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    Column {
        id: upColumn
        spacing: 10
        visible: pageType === pageTypeUp
        width: 300
        z: 998
        anchors {
            top: focusItem.bottom
            topMargin: 5
            horizontalCenter: focusItem.horizontalCenter
        }
        CusImage {
            source: CusConfig.imagePathPrefix + "arrow-up.png"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    CusLabel {
        id: wizardDescriptLabel
        z: 998
        text: qsTr(wizardDescript) + CusConfig.transString
        font.pixelSize: 16
        color: "white"
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: 50
            horizontalCenterOffset: -50
        }
    }
    CusLabel {
        z: 998
        text: qsTr(wizardName) +  CusConfig.transString
        font.pixelSize: 26
        color: "white"
        anchors {
            left: wizardDescriptLabel.left
            bottom: wizardDescriptLabel.top
            bottomMargin: 30
        }
    }

}
