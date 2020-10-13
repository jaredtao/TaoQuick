import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

Item {
    id: drawRectItem
    property int oldX
    property int oldY
    property int drawX: Math.floor(drawRect.x)
    property int drawY: Math.floor(drawRect.y)
    property int drawW: Math.floor(drawRect.width)
    property int drawH: Math.floor(drawRect.height)
    signal pressed(real mouseX, real mouseY)
    signal released
    signal positionChanged(real mouseX, real mouseY)
    signal doubleClicked(real mouseX, real mouseY)
    signal wheelEvent(real angle)
    property bool bPressed: false
    MouseArea {
        id: drawArea
        anchors.fill: parent
        hoverEnabled: true

        onPressed: {
            bPressed = true
            oldX = Math.floor(mouseX)
            oldY = Math.floor(mouseY)
            drawRectItem.pressed(mouseX, mouseY)
        }
        onReleased: {
            drawRectItem.released()
            bPressed = false
        }

        onPositionChanged: {
            drawRectItem.positionChanged(mouseX, mouseY)
        }
        onDoubleClicked: {
            bPressed = false
            drawRectItem.doubleClicked(mouseX, mouseY)
        }
        onWheel: {
            drawRectItem.wheelEvent(wheel.angleDelta.y / 8)
        }
    }
    Rectangle {
        id: drawRect
        visible: bPressed
        property int mx: bound(0, drawArea.mouseX, drawRectItem.width)
        property int my: bound(0, drawArea.mouseY, drawRectItem.height)
        property int w: Math.abs(mx - oldX)
        property int h: Math.abs(my - oldY)
        property int minX: Math.min(mx, oldX)
        property int minY: Math.min(my, oldY)
        x: Math.max(0, minX)
        y: Math.max(0, minY)
        width: Math.min(w, drawRectItem.width - x)
        height: Math.min(h, drawRectItem.height - y)
        color: Config.tableSelectRectColor
        border.color: Qt.darker(color, 1.4)
        opacity: 0.3
    }
    function bound(minValue, midValue, maxValue) {
        return Math.max(minValue, Math.min(midValue, maxValue))
    }
}
