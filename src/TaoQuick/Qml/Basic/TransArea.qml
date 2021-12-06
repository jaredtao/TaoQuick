import QtQuick 2.9
import QtQuick.Controls 2.2

//鼠标事件透传
MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    //    propagateComposedEvents: true
    //鼠标图标， hovered 或者 pressed时显示此图标
    cursorShape: Qt.PointingHandCursor
    onDoubleClicked: function (mouse) {
        mouse.accepted = false
    }
    onPositionChanged: function (mouse) {
        mouse.accepted = false
    }
    onPressed: function (mouse) {
        mouse.accepted = false
    }
    onPressAndHold: function (mouse) {
        mouse.accepted = false
    }
    onClicked: function (mouse) {
        mouse.accepted = false
    }
    onReleased: function (mouse) {
        mouse.accepted = false
    }
    onWheel: function (wheel) {
        wheel.accepted = false
    }
}
