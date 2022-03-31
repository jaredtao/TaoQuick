import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Shapes 1.12


Rectangle {
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
            strokeColor: "black"
            fillColor: "white"
            strokeWidth: 3

            SequentialAnimation on strokeColor {
                loops: Animation.Infinite
                ColorAnimation {
                    from: "black"
                    to: "green"
                    duration: 5000
                }
                ColorAnimation {
                    from: "green"
                    to: "yellow"
                    duration: 5000
                }
                ColorAnimation {
                    from: "yellow"
                    to: "black"
                    duration: 5000
                }
            }

            startX: ctr.width/2; startY: 80
            PathLine { x: ctr.width/2 + 50; y: 80 + 100 }
            PathLine { x: ctr.width/2 - 50; y: 80 + 100 }
            PathLine { x: ctr.width/2; y: 80 }
        }
    }
}
