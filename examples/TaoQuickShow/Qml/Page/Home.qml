import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0
Item {
    id: homeItem
    anchors.centerIn: parent
    CusLabel {
        text: qsTr("TaoQuick provides a set of controls that can be used to build complete interfaces in Qt Quick.") + trans.transString
        horizontalAlignment: Label.AlignHCenter
        verticalAlignment: Label.AlignVCenter
        wrapMode: Label.Wrap
        anchors.centerIn: parent
    }
    property ListModel wizardModel: ListModel {
        ListElement {
            name: "TitleBar"
            descript: "drag change window pos, double click change window state"
            targetObjectName: "blankItem"
            arrowType: Qt.UpArrow
        }
        ListElement {
            name: "Control Buttons"
            descript: "minimize, maximize, normal or close main window"
            targetObjectName: "controlButtonsRow"
            arrowType: Qt.UpArrow
        }
        ListElement {
            name: "Skin Button"
            descript: "switch theme"
            targetObjectName: "skinBtn"
            arrowType: Qt.UpArrow
        }
        ListElement {
            name: "Language Button"
            descript: "switch language"
            targetObjectName: "langBtn"
            arrowType: Qt.UpArrow
        }
        ListElement {
            name: "Left Pane"
            descript: "show content list"
            targetObjectName: "leftPane"
            arrowType: Qt.LeftArrow
        }
        ListElement {
            name: "Drawer Button"
            descript: "show or hide left pane"
            targetObjectName: "menuBtn"
            arrowType: Qt.LeftArrow
        }
        ListElement {
            name: "Search Input"
            descript: "search content"
            targetObjectName: "searchInput"
            arrowType: Qt.LeftArrow
        }
        ListElement {
            name: "Home Button"
            descript: "go back home page"
            targetObjectName: "homeBtn"
            arrowType: Qt.LeftArrow
        }
        ListElement {
            name: "Content List"
            descript: "switch content"
            targetObjectName: "contentListView"
            arrowType: Qt.LeftArrow
        }
        ListElement {
            name: "Content Pane"
            descript: "show current selected content by list"
            targetObjectName: "contentRect"
            arrowType: Qt.RightArrow
        }
        ListElement {
            name: "Tool Buttons"
            descript: "special function buttons such as Wizard, View Source Code and so on"
            targetObjectName: "wizardBtn"
            arrowType: Qt.RightArrow
        }

    }
}
