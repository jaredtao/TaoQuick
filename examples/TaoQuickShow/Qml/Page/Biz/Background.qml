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
        text: trans.trans("Background") + trans.transString
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
}
