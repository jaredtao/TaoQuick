import QtQuick 2.12
import QtQuick.Controls 2.12
Rectangle {
    id: root
    property alias textItem: t      //导出Text实例，方便外部直接修改
    property alias text: t.text     //导出文本
    property alias textColor: t.color   //导出文本颜色
    property alias containsMouse: area.containsMouse    //导出鼠标悬浮
    property alias containsPress: area.containsPress    //导出鼠标按下
    signal clicked();               //自定义点击信号
    color: "transparent"
    Text {
        id: t
        //默认坐标居中
        anchors.centerIn: parent
        //默认文字对齐方式为水平和垂直居中
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        //默认宽度为parent的宽度，这样字太长超出范围时自动显示省略号
        width: parent.width
        elide: Text.ElideRight
    }

    MouseArea {
        id: area
        anchors.fill: parent;
        hoverEnabled: parent.enabled;
        onClicked: root.clicked();  //点击时触发自定义点击信号
        cursorShape: Qt.PointingHandCursor  //悬浮或点击时的鼠标样式
    }
}

