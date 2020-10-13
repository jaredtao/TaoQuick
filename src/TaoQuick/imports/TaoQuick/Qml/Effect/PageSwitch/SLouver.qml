import QtQuick 2.9
import QtQuick.Controls 2.2
import "../.."
Item {
    id: container

    property int duration: 800

    enum Direct {
        Horizon = 0,
        Vertical = 1,
        HorizonReverse = 2,
        VerticalReverse = 3
    }

    property int dir: SLouver.Direct.Horizon

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
