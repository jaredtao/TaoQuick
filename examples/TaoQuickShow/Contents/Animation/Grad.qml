import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

AnimationBase {
    anchors.fill: parent
    Image {
        id: src

        source: imgPath + "Effect/Girls/girl6.jpeg"
        visible: false
    }
    Grid {
        anchors.centerIn: parent
        columns: 2
        spacing: 40
        AGrad {
            id: g1
            width: 250
            height: 375
            effectSource.sourceItem: src
        }

        AGrad {
            id: g2
            width: 250
            height: 375
            dir: directFromRight
            effectSource.sourceItem: src
        }

        AGrad {
            id: g3
            width: 250
            height: 375
            dir: directFromTop
            effectSource.sourceItem: src
        }
        AGrad {
            id: g4
            dir: directFromBottom
            width: 250
            height: 375
            effectSource.sourceItem:  src

        }
    }
    Component.onCompleted: {
        ani.start()
    }
    SequentialAnimation {
        id: ani
        ScriptAction {script: {g1.restart() } }
        PauseAnimation {duration: 1200}
        ScriptAction {script: {g2.restart() } }
        PauseAnimation {duration: 1200}
        ScriptAction {script: {g3.restart() } }
        PauseAnimation {duration: 1200}
        ScriptAction {script: {g4.restart() } }
    }
    onReplayClicked: {
        ani.restart()
    }
}
