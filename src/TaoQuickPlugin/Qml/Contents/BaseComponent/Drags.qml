import QtQuick 2.12
import QtQuick.Controls 2.12

import TaoQuick 1.0
import "qrc:/TaoQuick"

Item {
    anchors.fill: parent

    Rectangle {
        x: 100
        y: 200
        width: 120
        height: 80
        color: "darkred"
        TMoveArea {
            control: parent
            anchors.fill: parent
        }
    }

    Rectangle {
        x: 300
        y: 200
        width: 120
        height: 80
        color: "darkred"
        TMoveArea {
            anchors.fill: parent
            control: parent
        }
        TResizeBorder {
            control: parent
            anchors.fill: parent

        }
    }
}
