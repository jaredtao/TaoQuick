import QtQuick 2.9
import QtQuick.Controls 2.2

import TaoQuick 1.0


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
