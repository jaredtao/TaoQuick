import QtQuick 2.9
import QtQuick.Controls 2.2
//鼠标事件透传
MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    propagateComposedEvents: true
    //鼠标图标， hovered 或者 pressed时显示此图标
    cursorShape: enabled ? Qt.PointingHandCursor : Qt.ForbiddenCursor
    onDoubleClicked: { mouse.accepted = false;}
    onPositionChanged: { mouse.accepted = false;}
    onPressed:  {  mouse.accepted = false; }
    onPressAndHold: { mouse.accepted = false; }
    onClicked:  { mouse.accepted = false;}
    onReleased: { mouse.accepted = false;}
    onWheel: { wheel.accepted = false; }
}
