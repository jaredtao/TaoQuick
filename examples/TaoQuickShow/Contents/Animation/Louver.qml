import QtQuick 2.12
import QtQuick.Controls 2.12
import TaoQuick 1.0
import "qrc:/TaoQuick"
Item {
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
            width: 460
            height: 280
            effectSource.sourceItem:  src
        }
        ALouver {
            id: l2
            width: 460
            height: 280
            dir: ALouver.Direct.HorizonReverse
            effectSource.sourceItem: src
        }
        ALouver {
            id: l3
            width: 460
            height: 280
            dir: ALouver.Direct.Vertical
            effectSource.sourceItem: src
        }
        ALouver {
            id: l4
            width: 460
            height: 280
            dir: ALouver.Direct.VerticalReverse
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
    Button {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        text: "replay"
        onClicked: {
            ani.restart()
        }
    }
}
