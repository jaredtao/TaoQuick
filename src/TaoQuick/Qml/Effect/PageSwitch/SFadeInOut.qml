import QtQuick 2.9
import QtQuick.Controls 2.2
Item {
    id: container

    property int duration: 800
    visible: false
    property Item sourceItem
    ShaderEffectSource {
        id: fade
        anchors.fill: parent
        sourceItem: container.sourceItem
        hideSource: true
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
                    target: fade
                    property: "opacity"
                    duration: container.duration
                    easing.type: Easing.InOutQuad
                    from: 1
                    to: 0
                    alwaysRunToEnd: true
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
                        fade.opacity = 0
                        container.visible = true
                    }
                }
                PauseAnimation {
                    duration: container.duration
                }
                NumberAnimation {
                    target: fade
                    property: "opacity"
                    duration: container.duration
                    easing.type: Easing.InOutQuad
                    from: 0
                    to: 1
                    alwaysRunToEnd: true
                }
            }
        }
    ]
}
