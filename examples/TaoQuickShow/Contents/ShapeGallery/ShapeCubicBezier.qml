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
            id: shapeRoot
            anchors.fill: parent

            ShapePath {
                strokeWidth: 4
                strokeColor: "black"

                startX: 30
                startY: 60
                // Defines a cubic Bezier curve with two control points.
                PathCubic {
                    x: 170; y: 60
                    control1X: circleA.x; control1Y: circleA.y
                    control2X: circleB.x; control2Y: circleB.y
                }
            }

            Rectangle {
                id: circleA
                color: "blue"
                width: 10
                height: 10
                radius:5
                SequentialAnimation {
                    loops: Animation.Infinite
                    running: true
                    NumberAnimation {
                        target: circleA
                        property: "x"
                        from: 0
                        to: shapeRoot.width
                        duration: 5000
                    }
                    NumberAnimation {
                        target: circleA
                        property: "x"
                        from: shapeRoot.width
                        to: 0
                        duration: 5000
                    }
                    NumberAnimation {
                        target: circleA
                        property: "y"
                        from: 0
                        to: shapeRoot.height
                        duration: 5000
                    }
                    NumberAnimation {
                        target: circleA
                        property: "y"
                        from: shapeRoot.height
                        to: 0
                        duration: 5000
                    }
                }
            }

            Rectangle {
                id: circleB
                color: "blue"
                width: 10
                height: 10
                radius:5
                x: shapeRoot.width - width
                SequentialAnimation {
                    loops: Animation.Infinite
                    running: true
                    NumberAnimation {
                        target: circleB
                        property: "y"
                        from: 0
                        to: shapeRoot.height
                        duration: 5000
                    }
                    NumberAnimation {
                        target: circleB
                        property: "y"
                        from: shapeRoot.height
                        to: 0
                        duration: 5000
                    }
                    NumberAnimation {
                        target: circleB
                        property: "x"
                        from: shapeRoot.width
                        to: 0
                        duration: 5000
                    }
                    NumberAnimation {
                        target: circleB
                        property: "x"
                        from: 0
                        to: shapeRoot.width
                        duration: 5000
                    }
                }
            }
        }
    }
}
