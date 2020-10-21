import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

AnimationBase {
    anchors.fill: parent
    ASlowEnter {
        id: a2
        width: 320
        height: 216
        x: (parent.width - width) / 2
        targetY: parent.height / 2 - height
        dir: directFromTop
        Image {
            anchors.fill: parent
            source: imgPath + "Effect/baby.jpg"
        }
    }
//    Rectangle {
//        width: 320
//        height: 216
//        anchors.centerIn: parent
//        border.width: 1
//        border.color: "red"
//        color: "transparent"
//    }
    ASlowEnter {
        id: a1
        width: 320
        height: 216
        x: (parent.width - width) / 2
        targetY: parent.height / 2
        dir: directFromBottom
        Image {
            anchors.fill: parent
            source: imgPath + "Effect/baby.jpg"
        }
    }

    ASlowEnter {
        id: a3
        width: 320
        height: 216
        targetX: (parent.width - width) / 2 - width
        y: (parent.height - height) / 2
        dir: directFromLeft
        Image {
            anchors.fill: parent
            source: imgPath + "Effect/baby.jpg"
        }
    }
    ASlowEnter {
        id: a4
        width: 320
        height: 216
        targetX: parent.width - (parent.width - width)/2
        y: (parent.height - height) / 2
        dir: directFromRight
        Image {
            anchors.fill: parent
            source: imgPath + "Effect/baby.jpg"
        }
    }
    ParallelAnimation {
        id: ani
        ScriptAction{ script: {a1.animation.start()} }
        ScriptAction{ script: {a2.animation.start()} }
        ScriptAction{ script: {a3.animation.start()} }
        ScriptAction{ script: {a4.animation.start()} }
    }
    Component.onCompleted: {
        ani.restart()
    }
    onReplayClicked: {
        ani.restart()
    }
}
