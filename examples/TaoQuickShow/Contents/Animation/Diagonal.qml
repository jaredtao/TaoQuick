import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

AnimationBase {
    anchors.fill: parent
    Image {
        id: src
        source: imgPath + "Effect/Girls/girl4.jpeg"
        visible: false
    }
    Grid {
        anchors.centerIn: parent
        columns: 2
        spacing: 40
        ADiagonal {
            id: d1
            width: 250
            height: 375
            dir: directFromLeftTop
            effectSource.sourceItem: src
        }
        ADiagonal {
            id: d2
            width: 250
            height: 375
            dir: directFromRightBottom
            effectSource.sourceItem: src
        }
        ADiagonal {
            id: d3
            width: 250
            height: 375
            dir: directFromRightTop
            effectSource.sourceItem: src
        }
        ADiagonal {
            id: d4
            width: 250
            height: 375
            dir: directFromLeftBottom
            effectSource.sourceItem: src
        }
    }
    Component.onCompleted: {
        ani.start()
    }
    SequentialAnimation {
        id: ani
        ScriptAction {script: {d1.restart() } }
        PauseAnimation {duration: 1200}
        ScriptAction {script: {d2.restart() } }
        PauseAnimation {duration: 1200}
        ScriptAction {script: {d3.restart() } }
        PauseAnimation {duration: 1200}
        ScriptAction {script: {d4.restart() } }
    }
    onReplayClicked: {
        ani.restart()
    }
}
