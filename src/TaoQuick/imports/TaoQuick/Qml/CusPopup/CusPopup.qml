import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
Item {
    id: root
    anchors.fill: parent
    property alias popupVisible: popup.visible
    property alias contentItem: popup.contentItem
    property color barColor: CusConfig.tipBackgroundColor
    property alias backgroundItem: background
    property real backgroundWidth: 200
    property real backgroundHeight: 160
    property color borderColor:  barColor
    property real borderWidth: 0

    property real verticalOffset: 24
    //矩形旋转45度，一半被toolTip遮住(重合)，另一半三角形和ToolTip组成一个带箭头的ToolTip
    Rectangle {
        id: bar
        visible: popup.visible
        rotation: 45
        width: verticalOffset
        height: width
        color: barColor
        border.color: borderColor
        //水平居中
        anchors.horizontalCenter: parent.horizontalCenter
        //垂直方向上，由ToolTip的y值，决定位置
        anchors.verticalCenter: parent.bottom
        anchors.verticalCenterOffset: verticalOffset
    }
    Popup {
        id: popup
        width: backgroundWidth
        height: backgroundHeight
        background: Rectangle {
            id: background
            color: barColor
            radius: 8
            border.color:borderColor
            border.width: borderWidth
        }
    }
    function show() {
        popup.x = (root.width - popup.width) / 2
        popup.y = root.height + verticalOffset
        popupVisible = true
    }
    function hide() {
        popupVisible = false
    }
}
