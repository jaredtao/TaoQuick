import QtQuick 2.12
import QtQuick.Controls 2.12

import TaoQuick 1.0
import "qrc:/TaoQuick"
Rectangle {
    id: root
    radius: 4
    color: gConfig.themeColor

    property var compNames: []
    property var comps:[]
    property alias icon: img.source
    signal closed()
    signal compClicked(string compUrl, string compName, int compIndex)
    ListView {
        id: listView
        model: compNames
        anchors {
            centerIn: parent
        }
        width: parent.width - 20
        height: contentHeight < parent.height - 100 ? contentHeight : parent.height - 100
        spacing: 4
        clip: true
        delegate: Rectangle {
            width: listView.width
            height: 40
            radius: 4
            color: (compBtn.containsMouse || compBtn.containsPress) ? Qt.darker(gConfig.themeColor, 1.2) : Qt.lighter(gConfig.themeColor, 1.2)
            CompBtn {
                id: compBtn
                text: modelData
                anchors.fill: parent
                onClicked: {
                    console.log("compClicked", comps[index])
                    root.compClicked(comps[index],modelData,index)
                }
            }
        }
    }
    Image {
        id: img
        width: sourceSize.width
        height: sourceSize.height
        anchors {
            right: parent.right
            top: parent.top
            rightMargin: 10
            topMargin: 10
        }
        NumberAnimation {
            target: img
            property: "rotation"
            running: true
            from: 0
            to: 360
            duration: 6 * 1000
            loops: Animation.Infinite
        }
    }
    BackBtn {
        anchors {
            left: parent.left
            top: parent.top
            leftMargin: 4
            topMargin: 4
        }
        onClicked: {
            root.closed();
        }
    }
}
