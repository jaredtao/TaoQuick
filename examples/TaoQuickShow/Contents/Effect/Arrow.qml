import QtQuick 2.9
import QtQuick.Controls 2.2
import "./Effects"
Rectangle {
    anchors.fill: parent
    color: "black"
    Item {
        id: arrowItem
        x: 10
        y: 10
        width: 300
        height: 300
        TArrow {
            id: arrow1
        }
        TArrow {
            id: arrow2
        }
        TArrow {
            id: arrow3
        }
        TArrow {
            id: arrow4
        }
        TArrow {
            id: arrow5
        }
        TArrow {
            id: arrow6
        }
        TArrow {
            id: arrow7
        }
        TArrow {
            id: arrow8
        }
        TArrow {
            id: arrow9
        }
    }
    Item {
        id: mirrorItem
        x: arrowItem.x
        y: arrowItem.y + arrowItem.height
        width: arrowItem.width
        height: arrowItem.height
        opacity: 0.3
        layer.enabled: true
        layer.effect: Component {
            ShaderEffectSource {
                sourceItem: arrowItem
                textureMirroring: ShaderEffectSource.MirrorVertically
            }
        }
        transform: Rotation {
            origin.x: mirrorItem.width / 2
            origin.y: mirrorItem.height / 2
            axis {x: 1; y: 0; z: 0}
            angle: 180
        }
    }
    Component.onCompleted: {
        seAnimation.start()
    }
    SequentialAnimation {
        id: seAnimation
        ScriptAction {script: arrow1.run()}
        PauseAnimation {duration: 200 }
        ScriptAction {script: arrow2.run()}
        PauseAnimation {duration: 200 }
        ScriptAction {script: arrow3.run()}

        PauseAnimation {duration: 500 }

        ScriptAction {script: arrow4.run()}
        PauseAnimation {duration: 200 }
        ScriptAction {script: arrow5.run()}
        PauseAnimation {duration: 200 }
        ScriptAction {script: arrow6.run()}

        PauseAnimation {duration: 500 }

        ScriptAction {script: arrow7.run()}
        PauseAnimation {duration: 200 }
        ScriptAction {script: arrow8.run()}
        PauseAnimation {duration: 200 }
        ScriptAction {script: arrow9.run()}
        PauseAnimation {duration: 200 }
    }
}
