import QtQuick 2.12
import QtQuick.Controls 2.12
Item {
    id: root
    anchors.fill: parent
    property alias text: toolTip.text
    property alias tipVisible: toolTip.visible
    property alias delay: toolTip.delay
    property alias timeout: toolTip.timeout
    property color barColor: "white"
    //矩形旋转45度，一半被toolTip遮住(重合)，另一半三角形和ToolTip组成一个带箭头的ToolTip
    Rectangle {
        id: bar
        visible: toolTip.visible
        rotation: 45
        width: 10
        height: 10
        color: barColor
        //水平居中
        anchors.horizontalCenter: parent.horizontalCenter
        //垂直方向上，由ToolTip的y值，决定位置
        anchors.verticalCenter: toolTip.y > 0 ? parent.bottom : parent.top
        anchors.verticalCenterOffset: toolTip.y > 0 ? 5 : -5
    }
    ToolTip {
        id: toolTip
        contentItem: Text {
            text: toolTip.text
        }
        background: Rectangle {
            id: background
            color: barColor
            radius: 8
        }
    }
}
