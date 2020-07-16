import QtQuick 2.12
import QtQuick.Controls 2.12
import TaoQuick 1.0
import "qrc:/TaoQuick"
Rectangle {
    id: root
    radius: 4
    color: gConfig.themeColor

    property int count: 0
    property alias icon: img.source
    property var compNames: []
    property var comps: []
    property bool raised: false

    signal closed()

    Image {
        id: img
        width: sourceSize.width
        height: sourceSize.height
        anchors {
            left: parent.left
            top: parent.top
            leftMargin: 4
            topMargin: 4
        }
    }
    ListView {
        id: listView
        model: compNames
        anchors {
            top: img.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            margins: 8
        }
        delegate: Item {
            width: listView.width
            height: 100

        }
    }

    CloseBtn {
        anchors {
            right: parent.right
            top: parent.top
            rightMargin: 4
            topMargin: 4
        }
        onClicked: {
            root.closed();
        }
    }
}
