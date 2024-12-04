import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

import "../.."
import "../Animation"
Item {
    id: container

    property int duration: 800
    visible: false

    property Item sourceItem
    property alias dir: board.dir
    ADiagonal {
        id: board
        anchors.fill: parent
        duration: container.duration
        effectSource.sourceItem: container.sourceItem
    }
    states: [
        State {
            name: "show"
        },
        State {
            name: "hide"
        }
    ]
    state: "hide"
    transitions: [
        Transition {
            to: "hide"
            SequentialAnimation {
                NumberAnimation {
                    target: board
                    property: "percent"
                    duration: container.duration
                    easing.type: Easing.InOutQuad
                    to: 0
                }
                ScriptAction {
                    script: {
                        container.visible = false
                    }
                }
            }
        },
        Transition {
            to: "show"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        container.visible = true
                    }
                }

                PauseAnimation {
                    duration: container.duration
                }
                NumberAnimation {
                    target: board
                    property: "percent"
                    duration: container.duration
                    easing.type: Easing.InOutQuad
                    to: 100
                }
            }
        }
    ]
}
