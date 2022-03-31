import QtQml 2.0
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Shapes 1.12

Rectangle {
    color: "lightGray"

    Shape {
        anchors.centerIn: parent
        width: 200
        height: 100

        ShapePath {
            id: rootPath
            strokeColor: "black"
            strokeWidth: 20

            property int index: 0
            property variant styles: [ ShapePath.FlatCap, ShapePath.SquareCap, ShapePath.RoundCap ]
            property variant styleText: [ "FlatCap", "SquareCap", "RoundCap" ]

            capStyle: styles[index]
            startX: 40; startY: 30

            PathLine { x: 40; y: 100}
            PathLine { x: 80; y: 100 }
            PathLine { x: 80; y: 30}
            PathLine { x: 160; y: 30}
            PathLine { x: 160; y: 100}
        }
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: rootPath.index = (rootPath.index + 1) % 3
    }

    Text {
        anchors.left: parent.left
        text: rootPath.styleText[rootPath.index]
    }
}
