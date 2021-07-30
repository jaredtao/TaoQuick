import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
CusButton {
    id: cusButton
    background: Rectangle {
        radius: cusButton.radius
        color: cusButton.backgroundColor
        border.color: cusButton.borderColor
        border.width: cusButton.borderWidth
        clip: true
        Rectangle {
            id: pressRect
            radius: 0
            smooth: true
            property int startX: cusButton.width / 2
            property int startY: cusButton.height / 2
            x: startX - radius
            y: startY - radius
            width: radius * 2
            height: radius * 2
            visible: radius > 0
            color: backgroundColorPressed

            SequentialAnimation {
                id: pressAnimation
                NumberAnimation {
                    target: pressRect
                    property: "radius"
                    from: 0
                    to: Math.max(pressRect.startX,
                                 cusButton.width - pressRect.startX)
                    duration: 500
                }
                ScriptAction {
                    script: {
                        pressRect.radius = 0
                    }
                }
            }
        }
    }

    TransArea {
        anchors.fill: parent
        onPressed: {
            pressRect.startX = mouseX
            pressRect.startY = mouseY
            pressAnimation.start()
        }
    }
}
