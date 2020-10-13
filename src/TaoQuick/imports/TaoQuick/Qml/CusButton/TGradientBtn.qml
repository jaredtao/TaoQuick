import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
Item {
    id: root

    property alias text: t.text
    property alias textColor: t.color
    property alias textAnchors: t.anchors
    property alias textHorizontalAlignment: t.horizontalAlignment
    property alias textVerticalAlignment: t.verticalAlignment

    property alias textItem: t
    property alias containsMouse: mouseBtn.containsMouse
    property alias containsPress: mouseBtn.containsPress

    signal clicked

    Rectangle {
        id: hoverRect
        anchors.fill: parent
        visible: root.containsMouse || root.containsPress
        color: Qt.lighter("gray")
        radius: 5
        clip: true
        Rectangle {
            id: pressRect
            radius: 0
            smooth: true
            property int startX: root.width / 2
            property int startY: root.height / 2
            x: startX - radius
            y: startY - radius
            width: radius * 2
            height: radius * 2
            visible: radius > 0
            color: "gray"

            SequentialAnimation {
                id: pressAnimation
                NumberAnimation {
                    target: pressRect
                    property: "radius"
                    from: 0
                    to: Math.max(pressRect.startX,
                                 root.width - pressRect.startX)
                    duration: 500
                }
                ScriptAction {
                    script: {
                        pressRect.radius = 0
                    }
                }
            }
        }
    }

    BasicText {
        id: t
        anchors.centerIn: parent
        width: parent.width
    }
    MouseArea {
        id: mouseBtn
        anchors.fill: parent
        hoverEnabled: parent.enabled
        onPressed: {
            pressRect.startX = mouseX
            pressRect.startY = mouseY
            pressAnimation.start()
        }
        onClicked: root.clicked()
        cursorShape: Qt.PointingHandCursor
    }
}
