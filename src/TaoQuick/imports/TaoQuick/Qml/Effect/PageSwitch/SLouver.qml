import QtQuick 2.9
import QtQuick.Controls 2.2
import "../.."
import "../Animation"
Item {
    id: container

    property int duration: 800

    readonly property int directHorizon: 0
    readonly property int directVertical: 1
    readonly property int directHorizonReverse: 2
    readonly property int directVerticalReverse: 3

    property int dir: directHorizonn

    property Item sourceItem
    visible: false
    ALouver {
        id: louver
        anchors.fill: parent
        dir: container.dir
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
                    target: louver
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
                    target: louver
                    property: "percent"
                    duration: container.duration
                    easing.type: Easing.InOutQuad
                    to: 100
                }
            }
        }
    ]
}
