import QtQuick 2.12
import QtQuick.Controls 2.12
import TaoQuick 1.0
import "qrc:/TaoQuick"
Item {
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
            width: 460
            height: 280
            dir: ACleavage.Direct.HorizonToInner
            effectSource.sourceItem: src
        }
        ACleavage {
            id: s2
            width: 460
            height: 280
            dir: ACleavage.Direct.HorizonToOuter
            effectSource.sourceItem: src
        }
        ACleavage {
            id: s3
            width: 460
            height: 280
            dir: ACleavage.Direct.VerticalToInner
            effectSource.sourceItem: src
        }
        ACleavage {
            id: s4
            width: 460
            height: 280
            dir: ACleavage.Direct.VerticalToOuter
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
    Button {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        text: "replay"
        onClicked: {
            ani.restart()
        }
    }
}
