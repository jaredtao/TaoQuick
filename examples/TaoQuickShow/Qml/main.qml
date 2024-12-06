import QtQml
import QtQuick
import QtQuick.Controls

import TaoQuick

import "./Page"
import "./Pane"
import "./Dialog"
import Qt.labs.platform
CusBackground {
    id: rootBackground
    width: 1440
    height: 960
    CusImage {
        id: bgImg
        source: imgPath + "Window/flower.jpg"
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        opacity: 0.1
    }
    SystemTrayIcon {
        id: sysTray
        visible: true
        icon.source: imgPath + "logo/milk.png"
        menu: Menu {
            MenuItem {
                text: qsTr("Quit")
                onTriggered: {
                    rootView.close()
                }
            }
        }
    }

    //Windows use native event for frameless
    //Other platform use CusResizeBorder
    CusResizeBorder {
        id: resizeBorder
        borderWidth: 4
        enabled: visible
        anchors.fill: rootBackground
        control: rootView
    }
    AboutDialog {
        id: aboutDialog
    }
    //    SettingsDialog {
    //        id: settingDialog
    //    }
    TitlePane {
        id: title
        width: parent.width
        height: 60
    }
    Item {
        id: content
        width: parent.width - resizeBorder.borderWidth * 2
        x: resizeBorder.borderWidth
        anchors {
            top: title.bottom
            bottom: parent.bottom
            bottomMargin: resizeBorder.borderWidth
        }
        CusFPS {
            anchors {
                right: parent.right
                top: parent.top
                rightMargin: 5
            }
        }

        LeftPane {
            id: leftPane
            objectName: "leftPane"
            property real targetW: parent.width * 0.233
            width: targetW
            height: parent.height
            property bool isOpen: true
            x: isOpen ? 0 : -targetW - 4
            Behavior on x {
                NumberAnimation { duration: 350}
            }
            onLoadHome: function() {
                rightPane.source = rightPane.homeUrl
            }
            onLoadContent: function(path) {
                rightPane.source = contentsPath + path
            }
        }
        CusButton_ImageColorOverlay {
            btnImgNormal: imgPath + "Common/menu.png"
            objectName: "menuBtn"
            anchors {
                left: leftPane.right
                top: leftPane.top
                topMargin: 5
            }
            width: 32
            height: 32
            onClicked: {
                leftPane.isOpen = !leftPane.isOpen
            }
        }
        Rectangle {
            width: 1
            anchors {
                top: leftPane.top
                bottom: leftPane.bottom
                right: leftPane.right
            }
            color: CusConfig.controlBorderColor
        }
        RightPane {
            id: rightPane
            objectName: "contentRect"
            anchors {
                left: leftPane.right
                leftMargin: 40
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }
        }
    }


    ClickShow {
        anchors.fill: parent
        anchors.margins: 10
    }
}
