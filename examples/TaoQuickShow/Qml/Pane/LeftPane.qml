import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

Item {

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
    ListModel {
        id: demoModel
        ListElement {
            name: "Basic"
            section: "1"
        }
        ListElement {
            name: "Button"
            section: "1"
        }
        ListElement {
            name: "CheckBox"
            section: "1"
        }
        ListElement {
            name: "ComboBox"
            section: "2"
        }
        ListElement {
            name: "Image"
            section: "3"
        }
        ListElement {
            name: "Input"
            section: "3"
        }
        ListElement {
            name: "Label"
            section: "3"
        }
        ListElement {
            name: "Popup"
            section: "3"
        }
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
        section.property: "section"
        section.delegate: ItemDelegate {
            width: listView.width
            height: CusConfig.fixedHeight
            CusLabel {
                text: section
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
        }
        delegate: ItemDelegate {
            width: listView.width
            height: CusConfig.fixedHeight
            CusLabel {
                anchors.centerIn: parent
                text: name
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}
