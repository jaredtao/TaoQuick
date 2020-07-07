import QtQuick 2.12
import QtQuick.Controls 2.12
import TaoQuick 1.0
import "qrc:/TaoQuick"
Rectangle {
    id: root
    width: 200
    height: 80
    radius: 10
    color: gConfig.themeColor

    property alias name: t.text
    property int count: 0
    property alias icon: img.source
    property var compNames: []
    property bool raised: false

    signal clicked()
    signal closed()

    MouseArea {
        id: area
        anchors.fill: parent
        onClicked: {
            rise(true);
            root.clicked()
        }
    }
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

    TTextBtn {
        anchors{
            right: parent.right
            top: parent.top
        }
        width: 30
        height: 24
        text: "X"
        onClicked: {
            rise(false);
            root.closed();
        }
        visible: raised
    }

    ARiseSet {
        id: ani
        targetItem: targetParent
        Component.onCompleted: {
            setX = root.x;
            setY = root.y;
            setW = root.width;
            setH = root.height;
            riseW = 400;
            riseH = 300;
            riseX = (targetParent.width - riseW ) / 2;
            riseY = (targetParent.height - riseH ) / 2;
            let o = root.mapFromItem(targetParent, riseX, riseY)
            riseX = o.x
            riseY = o.y
            console.log("ARiseSet", targetParent.width, targetParent.width, riseX, riseY)
        }
    }
    function rise(value) {
        if (value) {
            if (!raised) {
                raised = true;
                ani.riseAnimation.start();
            }
        } else {
            if (raised) {
                raised = false;
                ani.setAnimation.start()
            }
        }
    }
}
