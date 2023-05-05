import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Shapes 1.12


Rectangle {
    width: 120
    height: 120
    color: th.pressed ? "steelBlue" : "lightGray"

    TapHandler { id: th }

    Shape {
        id: shape
        anchors.fill: parent

        ShapePath {
            id: p
            strokeWidth: 3
            strokeColor: "black"
            fillColor: "white"

            property real xr: 70
            property real yr: 30
            startX: shape.width / 2 - xr
            startY: shape.height / 2 - yr
            PathArc {
                x: shape.width / 2 + p.xr
                y: shape.height / 2 + p.yr
                radiusX: p.xr; radiusY: p.yr
                useLargeArc: true
            }
            PathArc {
                x: shape.width / 2 - p.xr
                y: shape.height / 2 - p.yr
                radiusX: p.xr; radiusY: p.yr
                useLargeArc: true
            }
        }
    }
}
