import QtQuick 2.12
import QtQuick.Controls 2.12
Rectangle {
    id: root
    property url normalUrl
    property url hoveredUrl
    property url pressedUrl
    property url disabledUrl

    property alias imageItem: img
    property alias imageUrl: img.source
    property alias imageWidth: img.width
    property alias imageHeight: img.height

    property alias textItem: t
    property alias text: t.text
    property alias textColor: t.color
    property alias containsMouse: area.containsMouse
    property alias containsPress: area.containsPress
    signal clicked();

    //5.10以前的版本，Qml中没有枚举，用int属性代替枚举
    property int layoutType: layoutImageLeft    //布局类型,默认图片在左，外部可修改
    readonly property int layoutImageLeft: 0    //图片在左 只读属性，代替枚举
    readonly property int layoutImageRight: 1   //图片在右 只读属性，代替枚举
    readonly property int layoutImageUp: 2      //图片在上 只读属性，代替枚举
    readonly property int layoutImageDown: 3    //图片在下 只读属性，代替枚举
    color: "transparent"
    Image {
        id: img
        source: root.enabled ? (containsPress ? pressedUrl : (containsMouse ? hoveredUrl : normalUrl)) : disabledUrl
    }
    Text {
        id: t
        //默认文字对齐方式为水平和垂直居中
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
    //按布局类型 处理布局
    Component.onCompleted: {
        switch (layoutType) {
        case layoutImageLeft:
            img.anchors.verticalCenter = root.verticalCenter
            t.anchors.verticalCenter = root.verticalCenter
            img.anchors.left = root.left
            t.anchors.left = img.right
            t.anchors.leftMargin = 6
            break;
        case layoutImageRight:
            img.anchors.verticalCenter = root.verticalCenter
            t.anchors.verticalCenter = root.verticalCenter
            t.anchors.left = root.left
            img.anchors.left = t.right
            img.anchors.leftMargin = 6
            break
        case layoutImageUp:
            img.anchors.horizontalCenter = root.horizontalCenter
            t.anchors.horizontalCenter = root.horizontalCenter
            img.anchors.top = root.top
            t.anchors.top = img.bottom
            t.anchors.topMargin = 6
            break
        case layoutImageDown:
            img.anchors.horizontalCenter = root.horizontalCenter
            t.anchors.horizontalCenter = root.horizontalCenter
            t.anchors.top = root.top
            img.anchors.top = t.bottom
            img.anchors.topMargin = 6
            break;
        }
    }
    MouseArea {
        id: area
        anchors.fill: parent;
        hoverEnabled: parent.enabled;
        onClicked: root.clicked();
        cursorShape: Qt.PointingHandCursor
    }
}

