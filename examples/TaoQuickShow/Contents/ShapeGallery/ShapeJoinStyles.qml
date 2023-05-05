import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Shapes 1.12


Rectangle {
    color: "lightGray"

    Shape {
        width: 120
        height: 120
        anchors.centerIn: parent

        ShapePath {
            id: rootPath

            strokeColor: "black"
            strokeWidth: 20
            capStyle: ShapePath.RoundCap

            property int index: 0
            property variant styles: [ ShapePath.BevelJoin, ShapePath.MiterJoin, ShapePath.RoundJoin ]
            property variant styleText: [ "BevelJoin", "MiterJoin", "RoundJoin" ]

            joinStyle: styles[index]

            startX: 30
            startY: 30
            PathLine { x: 100; y: 30 }
            PathLine { x: 100; y: 100 }
            PathLine { x: 30; y: 100 }
            PathLine { x: 30; y: 30 }
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
