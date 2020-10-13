import QtQuick 2.12
import QtQuick.Controls 2.12

MouseArea {
    id: root

    property real lastX: 0
    property real lastY: 0
    property bool mask: false       //有时候外面需要屏蔽拖动，导出一个mask属性， 默认false。
    property var control: parent   //导出一个control属性，指定要拖动的目标， 默认就用parent好了。注意目标要有x和y属性并且可修改
    onPressed: {
        lastX = mouseX;
        lastY = mouseY;
    }
    onContainsMouseChanged: { //修改一下鼠标样式，以示区别
        if (containsMouse) {
            cursorShape = Qt.SizeAllCursor;
        } else {
            cursorShape = Qt.ArrowCursor;
        }
    }
    onPositionChanged: {
        if (!mask && pressed && control)
        {
            control.x +=mouseX - lastX
            control.y +=mouseY - lastY
        }
    }
}
