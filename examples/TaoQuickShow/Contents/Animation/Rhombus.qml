import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

AnimationBase {
    anchors.fill: parent
    Image {
        id: src
        source: imgPath + "Effect/Girls/girl8.jpeg"
        visible: false
    }
    Grid {
        anchors.centerIn: parent
        spacing: 40
        columns: 2

        ARhombus {
            id: l1
            width: 250
            height: 375
            dir: directFromInner
            effectSource.sourceItem:  src
        }
        ARhombus {
            id: l2
            width: 250
            height: 375
            dir: directFromOuter
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
    }
    onReplayClicked: {
        ani.restart()
    }
}
