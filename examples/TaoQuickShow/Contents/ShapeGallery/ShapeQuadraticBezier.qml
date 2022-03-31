import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Shapes 1.12


Rectangle {
    color: "lightGray"

    Item {
        width: 200
        height: 100
        anchors.centerIn: parent

        Shape {
            id: shape
            anchors.fill: parent

            ShapePath {
                strokeWidth: 4
                strokeColor: "black"

                startX: 30
                startY: 60
                // Defines a quadratic Bezier curve with a control point
                PathQuad {
                    x: 170; y: 60
                    controlX: circle.x; controlY: circle.y
                }
            }
        }

        Rectangle {
            id: circle
            color: "blue"
            width: 10
            height: 10
            radius: 5
            SequentialAnimation on x {
                // the animation will continuously repeat until it is explicitly stopped
                loops: Animation.Infinite
                NumberAnimation {
                    from: 0
                    to: 200
                    duration: 5000
                }
            }
        }
    }
}
