import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

AnimationBase {
    anchors.fill: parent
    Image {
        id: src
        source: imgPath + "Effect/Girls/girl7.jpeg"
        visible: false
    }
    Grid {
        anchors.centerIn: parent
        spacing: 40
        columns: 2

        ALouver {
            id: l1
            width: 250
            height: 375
            effectSource.sourceItem:  src
        }
        ALouver {
            id: l2
            width: 250
            height: 375
            dir: directHorizonReverse
            effectSource.sourceItem: src
        }
        ALouver {
            id: l3
            width: 250
            height: 375
            dir: directVertical
            effectSource.sourceItem: src
        }
        ALouver {
            id: l4
            width: 250
            height: 375
            dir: directVerticalReverse
            effectSource.sourceItem: src
        }

    }
    Component.onCompleted: {
        ani.start()
    }
    SequentialAnimation {
        id: ani
        ScriptAction {script: {l1.restart() } }
        PauseAnimation {duration: 1200}
        ScriptAction {script: {l2.restart() } }
        PauseAnimation {duration: 1200}
        ScriptAction {script: {l3.restart() } }
        PauseAnimation {duration: 1200}
        ScriptAction {script: {l4.restart() } }
    }
    onReplayClicked: {
        ani.restart()
    }
}
