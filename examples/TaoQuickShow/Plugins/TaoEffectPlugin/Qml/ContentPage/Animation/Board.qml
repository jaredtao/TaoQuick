import QtQuick 2.12
import QtQuick.Controls 2.12

import TaoQuick 1.0
import "qrc:/TaoQuick"

Item {
    anchors.fill: parent
    Image {
        id: src
        source: "qrc:/EffectImage/Img/girl.jpg"
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
            dir: ABoard.Direct.ToBottom
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
    Button {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        text: "replay"
        onClicked: {
            ani.restart()
        }
    }
}
