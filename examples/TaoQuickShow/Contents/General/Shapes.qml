import QtQuick 2.9
import QtQuick.Shapes 1.0

Rectangle {
    id: root
    width: 1024
    height: 768

    property color col: "lightsteelblue"

    ListModel {
        id: pathGalleryModel
        ListElement {
            name: "Rectrangle"
            shapeUrl: "../ShapeGallery/ShapeRectrangle.qml"
        }
        ListElement {
            name: "Triangle"
            shapeUrl: "../ShapeGallery/ShapeTriangle.qml"
        }
        ListElement {
            name: "Circle"
            shapeUrl: "../ShapeGallery/ShapeCircle.qml"
        }
        ListElement {
            name: "Ellipse"
            shapeUrl: "../ShapeGallery/ShapeEllipse.qml"
        }
    }

    property int gridSpacing: 10

    Component {
        id: pathGalleryDelegate
        Rectangle {
            border.color: "purple"
            width: grid.cellWidth - root.gridSpacing
            height: grid.cellHeight - root.gridSpacing
            Column {
                anchors.fill: parent
                anchors.margins: 4
                Item {
                    width: parent.width
                    height: parent.height - delegText.height
                    Loader {
                        source: Qt.resolvedUrl(shapeUrl)
                        anchors.fill: parent
                    }
                }
                Text {
                    id: delegText
                    text: model.name
                    font.pointSize: 16
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 10
        color: "transparent"
        clip: true

        GridView {
            id: grid
            anchors.fill: parent
            anchors.margins: root.gridSpacing
            cellWidth: 300
            cellHeight: 300
            delegate: pathGalleryDelegate
            model: pathGalleryModel
        }
    }
}