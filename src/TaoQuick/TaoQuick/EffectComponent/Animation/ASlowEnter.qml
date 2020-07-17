import QtQuick 2.12
import QtQuick.Controls 2.12
import "../.."
Item {
    id: r
    property int targetX: 0
    property int targetY: 0
    property alias animation: animation
    enum Direct {
        FromLeft = 0,
        FromRight = 1,
        FromTop = 2,
        FromBottom = 3
    }
    property int dir: ASlowEnter.Direct.FromBottom
    property int duration: 2000
    property int extDistance: 10
    property var __propList: ["x", "x", "y", "y"]
    property var __fromList: [
        -r.parent.width - r.width - extDistance,
        r.parent.width + r.width + extDistance,
        -r.parent.height - r.height - extDistance,
        r.parent.height + r.height + extDistance]
    property var __toList: [targetX, targetX, targetY, targetY]
    NumberAnimation {
        id: animation
        target: r
        property: __propList[dir]
        from: __fromList[dir]
        to: __toList[dir]
        duration: r.duration
        loops: 1
//        alwaysRunToEnd: true
    }
}
