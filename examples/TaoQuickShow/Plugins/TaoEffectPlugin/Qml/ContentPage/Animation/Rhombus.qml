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
    Grid {
        anchors.centerIn: parent
        spacing: 40
        columns: 2

        ARhombus {
            id: l1
            width: 460
            height: 280
            dir: ARhombus.Direct.FromInner
            effectSource.sourceItem:  src
        }
        ARhombus {
            id: l2
            width: 460
            height: 280
            dir: ARhombus.Direct.FromOuter
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
    Button {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        text: "replay"
        onClicked: {
            ani.restart()
        }
    }
}
