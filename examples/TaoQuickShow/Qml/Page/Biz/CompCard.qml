import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

Rectangle {
    id: root
    width: 200
    height: 80
    radius: 10
    color: containsMouse ? Qt.lighter(gConfig.themeColor, 1.2) : (containsPress ? Qt.darker(gConfig.themeColor, 1.2) : gConfig.themeColor)
    property alias name: t.text
    property int count: 0
    property alias icon: img.source
    property alias containsMouse: area.containsMouse    //导出鼠标悬浮
    property alias containsPress: area.containsPress    //导出鼠标按下
    signal clicked()
    Row {
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 20
        }
        spacing: 12
        Image {
            id: img
            width: sourceSize.width
            height: sourceSize.height

        }
        TText {
            id: t
            anchors{
                verticalCenter: parent.verticalCenter
            }
        }
    }

    CircleText {
        id: c
        text: count
        visible: count > 0

        anchors {
            right: parent.right
            top: parent.top
            rightMargin: -c.width / 3
            topMargin: -c.height / 3
        }
    }
    ToolTip {
        id: tip
        delay: 800
        text: qsTr(String("Component Name: %1, Count: %2")).arg(qsTr(name)).arg(count)
        visible: area.containsMouse
    }
    MouseArea {
        id: area
        anchors.fill: parent
        onClicked: {
            root.clicked()
        }
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }
}
