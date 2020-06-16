import QtQuick 2.12
import QtQuick.Controls 2.12

import TaoQuick 1.0
import "qrc:/TaoQuick"

Item {
    anchors.fill: parent

    GridView {
        id: g
        anchors.fill: parent
        anchors.margins: 20
        cellWidth: 160
        cellHeight: 160
        model: 180
        clip: true
        property var invalidList: [27, 39, 40, 45, 71, 74, 105, 111, 119, 130, 135, 141]
        delegate: Item{
            width: 160
            height: 160
            Rectangle{
                width: 150
                height: 150
                anchors.centerIn: parent
                color: "white"
                radius: 10
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    text: index + 1
                }
                Rectangle {
                    width: 100
                    height: width
                    radius:  width / 2
                    gradient: g.invalidList.indexOf(modelData + 1) < 0 ? modelData + 1 : null
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 10
                }
            }
        }
    }
}
