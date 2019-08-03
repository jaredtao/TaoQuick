import QtQuick 2.12
import QtQuick.Shapes 1.12
Shape {
    id: root
    property int maxValue: 100
    property int upShadow: 90
    property int upValue: 80
    property int downValue: 40
    property int downShadow: 30
    property int minValue: 10

    property color lineColor: "red"
    readonly property color trans: "transparent"
    property bool isFill: true
    property int lineWidth: 4
    ShapePath {
        startX: root.width / 2
        startY: root.height - maxValue
        strokeColor: lineColor
        strokeWidth: lineWidth
        PathLine {
            x: root.width / 2
            y: root.height - upValue
        }
    }
    ShapePath {
        startX: root.width / 2
        startY: root.height - minValue
        strokeColor: lineColor
        strokeWidth: lineWidth
        PathLine {
            x: root.width / 2
            y: root.height - downValue
        }
    }
    ShapePath {
        startX: 0
        startY: root.height - upValue
        strokeColor: lineColor
        strokeWidth: lineWidth
        fillColor: isFill ? lineColor : trans
        PathLine {
            x: root.width
            y: root.height - upValue
        }
        PathLine {
            x: root.width
            y: root.height - downValue
        }
        PathLine {
            x: 0
            y: root.height - downValue
        }
        PathLine {
            x: 0
            y: root.height - upValue
        }
    }
}
