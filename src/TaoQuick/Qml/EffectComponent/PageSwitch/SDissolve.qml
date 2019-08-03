import QtQuick 2.12
import QtQuick.Controls 2.12
import "../.."
Item {
    id: container

    property int duration: 1400
    visible: false

    property Item sourceItem
    property Image dissolveImage
    ADissolve {
        id: dissolve
        anchors.fill: parent
        duration: container.duration
        dissolveSource.sourceItem: dissolveImage
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
                    target: dissolve
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
                    target: dissolve
                    property: "percent"
                    duration: container.duration
                    easing.type: Easing.InOutQuad
                    to: 100
                }
            }
        }
    ]
}
