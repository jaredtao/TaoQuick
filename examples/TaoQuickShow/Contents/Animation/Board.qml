import QtQuick 2.9
import QtQuick.Controls 2.2

import TaoQuick 1.0


AnimationBase {
    anchors.fill: parent
    Image {
        id: src
        source: imgPath + "Effect/girl.jpg"
        visible: false
    }
    Row {
        anchors.centerIn: parent
        spacing: 20
        ABoard {
            id: a1
            width: 460
            height: 280
            effectSource.sourceItem: src
        }
        ABoard {
            id: a2
            width: 460
            height: 280
            dir: directToBottom
            effectSource.sourceItem: src
        }
    }
    Component.onCompleted: {
        ani.start()
    }
    SequentialAnimation {
        id: ani
        ScriptAction {script: {a1.restart() } }
        PauseAnimation {duration: 1200}
        ScriptAction {script: {a2.restart() } }
    }
    onReplayClicked: {
        ani.restart()
    }
}
