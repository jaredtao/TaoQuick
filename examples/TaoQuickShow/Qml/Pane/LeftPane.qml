import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

Item {
    id: leftPaneItem
    signal loadContent(string path)
    signal loadHome
    Item {
        width: parent.width
        height: 40
        CusTextField_Search {
            id: searchInput
            anchors {
                left: parent.left
                leftMargin: 4
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: 4
            }
        }
    }
    Rectangle {
        id: hLine
        width: parent.width
        height: 1
        y: 40
        color: CusConfig.controlBorderColor
    }

    ContentModel {
        id: demoModel
    }

    ListView {
        id: listView
        model: demoModel
        width: parent.width
        anchors {
            top: hLine.bottom
            topMargin: 4
            bottom: parent.bottom
        }
        currentIndex: -1
        header: Rectangle {
            id: home
            width: listView.width
            height: CusConfig.fixedHeight
            color: listView.currentIndex === -1 ? CusConfig.controlBorderColor_pressed : "transparent"
            opacity: 0.8
            CusTextButton {
                text: qsTr("Home") + trans.transString
                backgroundColor: "transparent"
                borderColor: "transparent"
                width: parent.width
                onClicked: {
                    listView.currentIndex = -1
                    loadHome()
                }
            }
        }
        delegate: Rectangle {
            width: listView.width
            height: CusConfig.fixedHeight
            color: ListView.isCurrentItem ? CusConfig.controlBorderColor_pressed : "transparent"
            opacity: 0.8
            CusTextButton {
                text: qsTr(model.name) + trans.transString
                backgroundColor: "transparent"
                borderColor: "transparent"
                onClicked: {
                    listView.currentIndex = index
                    loadContent(model.source)
                }
            }
        }
    }
}
