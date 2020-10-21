import QtQuick 2.9

Item {
    id: r
    implicitWidth: (soundWidth + columnSpacing) * columnCount
    implicitHeight: (soundHeight + rowSpacing) * rowCount
    Component {
        id: soundComp
        Image {
            source: imgPath + "Effect/soundRect.png"
            width: soundWidth
            height: soundHeight
        }
    }
    property bool running: true
    property int interval: 320
    property int soundWidth: 12
    property int soundHeight: 6

    property int rowCount: 15
    property int columnCount: 30

    property int rowSpacing: 4
    property int columnSpacing: 4

    property var objPool: []
    property var map:[]
    property int __arrayRatio: 100
    Component.onCompleted: {
        var startX = 0
        var startY = r.height - 12
        for (var i = 0; i < columnCount; ++i) {
            map.push(getRandomInt(0, rowCount))

            var px = startX + i * (soundWidth + columnSpacing)
            for (var j = 0; j < rowCount; ++j) {
                var py =  startY - j * (soundHeight + rowSpacing)

                var obj = soundComp.createObject(r, {"x": px, "y": py, "visible": false})
                objPool[i * __arrayRatio + j] = obj
            }
        }
    }
    Timer {
        interval: r.interval
        running: r.running
        repeat: true
        onTriggered: {
            map.push(getRandomInt(0, rowCount))
            map.shift()
            for (var i = 0; i < columnCount; ++i) {
                for (var j = 0; j < rowCount; ++j) {
                    objPool[i * __arrayRatio + j]["visible"] = j < map[i] ? true : false
                }
            }
        }
    }
    function getRandomInt(min, max) {
      min = Math.ceil(min);
      max = Math.floor(max);
      return Math.floor(Math.random() * (max - min)) + min; //不含最大值，含最小值
    }
}
