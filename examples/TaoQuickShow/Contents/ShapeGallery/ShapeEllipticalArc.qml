import QtQuick 2.12
import QtQuick.Shapes 1.12


Rectangle {
    color: "lightGray"
    Shape {
        id: shape
        width: 220
        height: 200
        anchors.centerIn: parent

        ShapePath {
            startX: 0; startY: 100
            fillColor: "white"
            strokeColor: "black"
            PathArc {
                relativeX: 50; relativeY: 0  // === x:50; y:100
                radiusX: 25; radiusY: 25
            }
            PathArc {
                relativeX: 50; relativeY: 0
                radiusX: 25; radiusY: 35
            }
            PathArc {
                x: 150; y: 100    // === relativeX: 50; y: 100
                radiusX: 25; radiusY: 60
            }
            PathArc {
                relativeX: 50; y: 100
                radiusX: 25; radiusY: 25
            }
        }
    }

    Shape {
        width: 220
        height: 100

        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10

        scale: 0.5

        ShapePath {
            fillColor: "white"
            strokeColor: "black"
            strokeWidth: 10

            // Defines an arc with the given radii and center
            PathAngleArc {
                centerX: 110; centerY: 95
                radiusX: 45; radiusY: 45
                sweepAngle:360
            }
        }
    }
}
