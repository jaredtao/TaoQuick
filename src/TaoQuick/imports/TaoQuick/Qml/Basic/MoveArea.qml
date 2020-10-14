import QtQuick 2.9
import QtQuick.Controls 2.2

MouseArea {
    id: moveArea

    property int lastX: 0
    property int lastY: 0
    property var control: parent //导出一个control属性，指定要拖动的目标， 默认就用parent好了。注意目标要有x和y属性并且可修改
    signal move(real xOffset, real yOffset)
    onContainsPressChanged: {
        if (containsPress) {
            cursorShape = Qt.SizeAllCursor
            lastX = mouseX
            lastY = mouseY
        } else {
            cursorShape = Qt.ArrowCursor
        }
    }
    onPositionChanged: {
        if (pressed && control) {
            if ((mouseX - lastX) !== 0 || (mouseY - lastY) !== 0)
                moveArea.move(mouseX - lastX, mouseY - lastY)
        }
    }
}
