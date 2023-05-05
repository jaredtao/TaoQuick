import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Shapes 1.12


Rectangle {
    id:root
    width: 120
    height: 120
    color: th.pressed ? "steelBlue" : "lightGray"
    containmentMask: ctr

    TapHandler { id: th }

    Shape {
        id: ctr
        anchors.fill: parent
        containsMode: Shape.FillContains

        ShapePath {
            strokeColor: "white"
            fillColor: "white"
            strokeWidth: 3

            startX: 90; startY: 90
            PathLine { x: 180; y: 90 }
            PathLine { x: 180; y: 180}
            PathLine { x: 90; y: 180 }
            PathLine { x: 90; y: 90 }
        }

        NumberAnimation on rotation {
            from: 0
            to: 360
            duration: 5000
            loops: Animation.Infinite
        }
    }
}
