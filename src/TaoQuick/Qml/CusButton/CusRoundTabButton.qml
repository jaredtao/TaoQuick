import QtQuick 2.9
import QtQuick.Controls 2.2
import "."
import ".."
import "../Basic"
import "../CusImage"

RoundRectangle {
    width: 30
    height: 30
    property string icon
    property real roundRadius: 8
    property int tabIndex: 0
    property int currentTabIndex: 0
    property bool isFirst: false
    property bool isLast: false
    property bool isSelected: currentTabIndex === tabIndex
    property bool isLastSelected: currentTabIndex === tabIndex -1
    property bool isNextSelected: currentTabIndex === tabIndex + 1

    property alias containsMouse: trans.containsMouse
    property alias hovered: trans.containsMouse
    property alias pressed: trans.pressed

    property bool showSplitLineLast: !hovered && !pressed && !isSelected && !isLastSelected
    property bool showSplitLineNext: !hovered && !pressed && !isSelected && !isNextSelected

    property color splitLineColor: "#bad4de"

    signal click()
    onIsLastSelectedChanged: {
        updateRadius()
    }
    onIsNextSelectedChanged: {
        updateRadius()
    }
    property var updateRadius: function updateRadius() {
        if (isFirst && isNextSelected) {
            radius = roundRadius
            rightBottomRound = true
            return
        }
        if (isLast && isLastSelected) {
            radius = roundRadius
            leftBottomRound = true
            return
        }
        if(isNextSelected || isLastSelected) {
            if(isNextSelected) {
                radius = roundRadius
                rightBottomRound = true
            }
            if(isLastSelected) {
                radius = roundRadius
                leftBottomRound = true
            }
        } else {
            radius = 0
            rightBottomRound = false
            leftBottomRound = false
        }
    }

    color: isSelected ? "#ffffff" : "#e3e3e3"

    CusImage {
        anchors.centerIn: parent
        sourceSize.width: 24
        sourceSize.height: 24
        source: icon
    }
    Rectangle {
        visible: showSplitLineLast
        width: 1
        height: parent.height * 0.8
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
        color: splitLineColor
    }
    Rectangle {
        visible: showSplitLineNext
        width: 1
        height: parent.height * 0.8
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        color: splitLineColor
    }
    TransArea {
        id: trans
        anchors.fill: parent
        onPressed: {
            click()
        }
    }
}



