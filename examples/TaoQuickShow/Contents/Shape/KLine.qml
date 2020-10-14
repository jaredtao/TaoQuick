import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

Item {
    anchors.fill: parent

    TKLine {
        x: 10
        y: 30
        width: 50
        height: 197
        upShadow: 110
        upValue: 150
        maxValue: 195
        downValue: 50
        minValue: 10
    }
    TKLine {
        x: 110
        y: 30
        width: 40
        height: 197
        lineWidth: 4
        isFill: false
        upValue: 120
        maxValue: 200
        lineColor: "green"
    }
}
