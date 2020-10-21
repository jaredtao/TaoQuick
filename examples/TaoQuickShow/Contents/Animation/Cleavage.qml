import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

AnimationBase {
    anchors.fill: parent
    Image {
        id: src
        width: 230
        height: 140
        source: imgPath + "Effect/Girls/girl2.jpeg"
        visible: false
    }
    Grid {
        anchors.centerIn: parent
        columns: 2
        spacing: 40
        ACleavage {
            id: s1
            width: 250
            height: 375
            dir: directHorizonToInner
            effectSource.sourceItem: src
        }
        ACleavage {
            id: s2
            width: 250
            height: 375
            dir: directHorizonToOuter
            effectSource.sourceItem: src
        }
        ACleavage {
            id: s3
            width: 250
            height: 375
            dir: directVerticalToInner
            effectSource.sourceItem: src
        }
        ACleavage {
            id: s4
            width: 250
            height: 375
            dir: directVerticalToOuter
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
        PauseAnimation {duration: 1200}
        ScriptAction {script: {s4.restart() } }
    }
    onReplayClicked: {
        ani.restart()
    }
}
