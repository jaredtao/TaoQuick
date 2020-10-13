import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0
import "qrc:/TaoQuick"
Item {
    anchors.fill: parent
    Image {
        id: src
        source: imgPath + "Effect/Girls/girl10.jpeg"
        visible: false
    }
    Grid {
        anchors.centerIn: parent
        columns: 2
        spacing: 40
        AWheel {
            id: s1
            width: 250
            height: 375
            dir: AWheel.Direct.Clockwise
            effectSource.sourceItem: src
        }
        AWheel {
            id: s2
            width: 250
            height: 375
            dir: AWheel.Direct.CounterClockwise
            effectSource.sourceItem: src
        }
        ASector {
            id: s3
            width: 250
            height: 375
            effectSource.sourceItem: src
        }
    }
    Component.onCompleted: {
        ani.start()
    }
    SequentialAnimation {
        id: ani
        ScriptAction {script: {s1.restart() } }
        PauseAnimation {duration: 1200}
        ScriptAction {script: {s2.restart() } }
        PauseAnimation {duration: 1200}
        ScriptAction {script: {s3.restart() } }
    }
    Button {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        text: "replay"
        onClicked: {
            ani.restart()
        }
    }
}
