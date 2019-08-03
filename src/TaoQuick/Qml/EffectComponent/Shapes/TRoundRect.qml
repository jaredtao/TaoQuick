import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Shapes 1.12
Shape {
    id: root
    property bool leftTopRound: true
    property bool leftBottomRound: true
    property bool rightTopRound: true
    property bool rightBottomRound: true
    property real radius
    property color color: "red"
    antialiasing: true
    ShapePath {
        fillColor: color
        startX: leftTopRound ? radius : 0
        startY: 0
//        fillRule: ShapePath.WindingFill
        PathLine {
            x: rightTopRound ? root.width - radius : root.width
            y: 0
        }
        PathArc {
            x: root.width
            y: rightTopRound ? radius : 0
            radiusX: rightTopRound ? radius : 0
            radiusY: rightTopRound ? radius : 0
        }

        PathLine {
            x: root.width
            y: rightBottomRound ? root.height - radius : root.height
        }
        PathArc {
            x: rightBottomRound ? root.width - radius : root.width
            y: root.height
            radiusX: rightBottomRound ? radius : 0
            radiusY: rightBottomRound ? radius : 0
        }
        PathLine {
            x: leftBottomRound ? radius : 0
            y: root.height
        }
        PathArc {
            x: 0
            y: leftBottomRound ? root.height - radius : root.height
            radiusX: leftBottomRound ? radius : 0
            radiusY: leftBottomRound ? radius : 0
        }

        PathLine {
            x: 0
            y: leftTopRound ? radius : 0
        }
        PathArc {
            x: leftTopRound ? radius : 0
            y: 0
            radiusX: leftTopRound ? radius : 0
            radiusY: leftTopRound ? radius : 0
        }
    }
}
