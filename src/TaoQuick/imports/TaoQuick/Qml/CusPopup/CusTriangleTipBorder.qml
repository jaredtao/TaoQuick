import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
Rectangle {
    id: cusTirangleTipBorder
    border.color: CusConfig.controlBorderColor
    color: CusConfig.backgroundColor
    radius: CusConfig.controlBorderRadius

    readonly property int trianglePosLeft: 0
    readonly property int trianglePosRight: 1
    readonly property int trianglePosTop: 2
    readonly property int trianglePosBottom: 3

    property int trangleWidth: 16
    property int trianglePos: trianglePosLeft

    property int triangleX: width / 2
    property int triangleY: height / 2

    Rectangle {
        id: triangleLeftRight
        visible: trianglePos === trianglePosLeft || trianglePos === trianglePosRight
        width: trangleWidth
        height: width
        rotation: 45
        y: triangleY
        x: (trianglePos === trianglePosLeft) ? -width / 2 + 2: cusTirangleTipBorder.width - width / 2 - 2
        color: parent.color
        border.color: parent.border.color
    }
    Rectangle {
        visible: trianglePos === trianglePosLeft || trianglePos === trianglePosRight
        width: triangleLeftRight.width
        height: triangleLeftRight.height * 1.5
        y: triangleLeftRight.y - 5
        x: (trianglePos === trianglePosLeft) ? 1 : cusTirangleTipBorder.width - width - 1
        color: parent.color
    }

    Rectangle {
        id: triangleTopBottom
        visible: trianglePos === trianglePosTop || trianglePos === trianglePosBottom
        width: trangleWidth
        height: width
        rotation: 45
        x: triangleX
        y: (trianglePos === trianglePosTop) ? -height / 2 + 2 : cusTirangleTipBorder.height - height / 2 - 2
        color: parent.color
        border.color: parent.border.color
    }
    Rectangle {
        visible: trianglePos === trianglePosTop || trianglePos === trianglePosBottom
        width: triangleTopBottom.width * 1.5
        height: triangleTopBottom.height
        x: triangleTopBottom.x - 5
        y: (trianglePos === trianglePosTop) ? 1 : cusTirangleTipBorder.height - height - 1
        color: parent.color
    }
}
