import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0
import "../Biz"

Item {
    id: leftPaneItem
    signal loadContent(string path)
    signal loadHome
    Item {
        width: parent.width
        height: 40
        CusTextField_Search {
            id: searchInput
            objectName: "searchInput"
            anchors {
                left: parent.left
                leftMargin: 4
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: 4
            }
            placeholderText: qsTr("Search") + trans.transString
            onTextChanged: {
                demoModel.search(text)
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
    Rectangle {
        id: home
        width: parent.width
        height: CusConfig.fixedHeight
        color: listView.currentIndex === -1 ? CusConfig.controlBorderColor_pressed : "transparent"
        opacity: 0.8
        anchors {
            top: hLine.bottom
            topMargin: 4
        }
        CusTextButton {
            text: qsTr("Home") + trans.transString
            objectName: "homeBtn"
            backgroundColor: "transparent"
            borderColor: "transparent"
            width: parent.width
            onClicked: {
                listView.currentIndex = -1
                loadHome()
            }
        }
    }
    CusListView {
        id: listView
        objectName: "contentListView"
        model: demoModel
        width: parent.width
        anchors {
            top: home.bottom
            topMargin: 4
            bottom: parent.bottom
        }
        currentIndex: -1
        noDataText: qsTr("No Data") + trans.transString

        section.property: "group"
        section.delegate: Item {
            width: listView.width
            height: CusConfig.fixedHeight
            ExpandBtn {
                id: sectionBtn
                text: qsTr(section) + trans.transString
                anchors {
                    left: parent.left
                }
                width: parent.width
                onClicked: {
                    isOpened = !isOpened
                    demoModel.updateSection(section, isOpened)
                }
            }
        }

        delegate: Rectangle {
            width: listView.width
            height: visible ? CusConfig.fixedHeight : 0
            visible: model.visible && model.groupOpen
            color: ListView.isCurrentItem ? CusConfig.controlBorderColor_pressed : "transparent"
            opacity: 0.8
            CusTextButton {
                id: btn
                anchors {
                    left: parent.left
                    leftMargin: 20
                }
                width: parent.width
                text: qsTr(model.name) + trans.transString
                backgroundColor: "transparent"
                borderColor: "transparent"
                onClicked: {
                    listView.currentIndex = index
                    loadContent(model.source)
                }
                contentItem: Item {
                    width: btn.width
                    height: btn.height
                    BasicText {
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        text: btn.text
                        color: btn.textColor
                    }
                }
            }
        }
    }
}
