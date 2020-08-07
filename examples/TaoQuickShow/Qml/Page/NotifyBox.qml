import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id: root
    implicitWidth: 200
    implicitHeight: 40
    property var control: parent
    x: control.width * 0.7
    y: control.height * 1.1
    color: gConfig.reserverColor
    opacity: 0.7
    visible: false
    Text {
        id: t
        anchors.centerIn: parent
    }
    SequentialAnimation {
        id: ani
        alwaysRunToEnd: false
        ScriptAction {
            script: root.visible = true
        }
        NumberAnimation {
            target: root
            property: "y"
            duration: 500
            easing.type: Easing.Linear
            to: control.height * 0.8
        }

        PauseAnimation {
            duration: 2400
        }
        NumberAnimation {
            target: root
            property: "y"
            duration: 500
            easing.type: Easing.Linear
            to: control.height * 1.1
        }
        ScriptAction {
            script: root.visible = false
        }

    }
    function notify(msg) {
        t.text = msg  + trans.transString
        ani.start()
    }
}
