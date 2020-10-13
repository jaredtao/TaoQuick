import QtQuick 2.9
import QtQuick.Controls 2.2

BusyIndicator {
    id: control
    width: 64
    height: 64
    property color busyColor: "#008b8b"
    property int busyRadius: 5
    property int busyCount: 6
    property int durationPerCycle: 1500

    contentItem: Item {
        width: control.width
        height: control.height
        Item {
            id: item
            width: parent.width
            height: parent.height
            opacity: control.running ? 1 : 0

            Behavior on opacity {
                OpacityAnimator {
                    duration: 250
                }
            }

            RotationAnimator {
                target: item
                running: control.visible && control.running
                from: 0
                to: 360
                loops: Animation.Infinite
                duration: durationPerCycle
            }

            Repeater {
                id: repeater
                model: busyCount

                Rectangle {
                    x: item.width / 2 - width / 2
                    y: item.height / 2 - height / 2
                    implicitWidth: busyRadius * 2
                    implicitHeight: busyRadius * 2
                    radius: busyRadius
                    color: busyColor
                    transform: [
                        Translate {
                            y: -Math.min(item.width, item.height) * 0.5 + busyRadius
                        },
                        Rotation {
                            angle: index / repeater.count * 360
                            origin.x: busyRadius
                            origin.y: busyRadius
                        }
                    ]
                }
            }
        }
    }
}
