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
        section.property: "group"
        section.delegate: Rectangle {
            width: listView.width
            height: CusConfig.fixedHeight
            opacity: 0.8
            CusButton {
                id: sectionBtn
                property bool isOpened: true
                text: qsTr(section) + trans.transString
                anchors {
                    left: parent.left
                }
                width: parent.width
                contentItem: BasicText {
                    x: 0
                    text: sectionBtn.text
                    color: sectionBtn.textColor
                    horizontalAlignment: Text.AlignLeft
                }
                background: Rectangle {
                    width: sectionBtn.width
                    height: sectionBtn.height
                    color: sectionBtn.pressed ? CusConfig.controlBorderColor_pressed : (sectionBtn.hovered ? CusConfig.controlBorderColor_hovered : CusConfig.controlBorderColor)
                    radius: 2
                    CusImage {
                        source: imgPath + "Button/expand.png"
                        anchors.right: parent.right
                        rotation: sectionBtn.isOpened ? 180 : 0
                        Behavior on rotation { NumberAnimation { duration: 200}}
                    }
                }
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
                anchors {
                    left: parent.left
                    leftMargin: 20
                }
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
