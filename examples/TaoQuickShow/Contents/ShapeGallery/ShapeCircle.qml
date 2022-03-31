import QtQml 2.0
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Shapes 1.12


Rectangle {
    width: 120
    height: 120
    color: th.pressed ? "steelBlue" : "lightGray"

    TapHandler { id: th }

    Shape {
        id: circ
        anchors.fill: parent

        SequentialAnimation on opacity {
            loops: Animation.Infinite
            NumberAnimation { from: 1.0; to: 0.0; duration: 5000 }
            NumberAnimation { from: 0.0; to: 1.0; duration: 5000 }
        }

        ShapePath {
            id: shapePath
            strokeWidth: 3
            strokeColor: "black"
            fillColor: "white"

            property real r: 40
            startX: circ.width / 2 - r
            startY: circ.height / 2 - r
            PathArc {
                x: circ.width / 2 + shapePath.r
                y: circ.height / 2 + shapePath.r
                radiusX: shapePath.r; radiusY: shapePath.r
                useLargeArc: true
            }
            PathArc {
                x: circ.width / 2 - shapePath.r
                y: circ.height / 2 - shapePath.r
                radiusX: shapePath.r; radiusY: shapePath.r
                useLargeArc: true
            }
        }
    }
}
