import QtQuick 2.0

Item {
    property int setX: 0
    property int setY: 0
    property int setW: 0
    property int setH: 0
    property int riseW: 0
    property int riseH: 0
    property int riseX: 0
    property int riseY: 0
    property int raiseDuration: 200
    property Item targetItem: null

    property alias riseAnimation: riseAnimation
    property alias setAnimation: setAnimation
    ParallelAnimation {
        id: riseAnimation
        alwaysRunToEnd: true
        loops: 1
        running: false
        NumberAnimation {
            target: targetItem
            property: "x"
            to: riseX
            duration: raiseDuration
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: targetItem
            property: "y"
            to: riseY
            duration: raiseDuration
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: targetItem
            property: "width"
            to: riseW
            duration: raiseDuration
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: targetItem
            property: "height"
            to: riseH
            duration: raiseDuration
            easing.type: Easing.InOutQuad
        }
    }

    ParallelAnimation {
        id: setAnimation
        alwaysRunToEnd: true
        loops: 1
        running: false
        NumberAnimation {
            target: targetItem
            property: "x"
            to: setX
            duration: raiseDuration
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: targetItem
            property: "y"
            to: setY
            duration: raiseDuration
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: targetItem
            property: "width"
            to: setW
            duration: raiseDuration
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: targetItem
            property: "height"
            to: setH
            duration: raiseDuration
            easing.type: Easing.InOutQuad
        }
    }
}
