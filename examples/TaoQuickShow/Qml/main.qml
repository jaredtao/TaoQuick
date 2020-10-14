import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0
import "./Page"
import Qt.labs.platform 1.1
Item {
    id: rootItem
    width: 1440
    height: 900

    ContentData {
        id: gConfig
        objectName: "gConfig"
    }
    SystemTrayIcon {
        id: sysTray
        visible: true
        icon.source: imgPath + "logo/milk.png"
        menu: Menu {
            MenuItem {
                text: qsTr("Quit")
                onTriggered: {
                    Qt.quit()
                }
            }
        }
    }
    AboutDialog {
        id: aboutDialog
    }
    SettingsDialog {
        id: settingDialog
    }

    TitlePage {
        id: title
        width: parent.width
        height: 60
        color: gConfig.themeColor
    }
    Rectangle {
        id: content
        width: parent.width
        anchors {
            top: title.bottom
            bottom: parent.bottom
        }
        color: gConfig.background
        TFPS {
            anchors {
                right: parent.right
                top: parent.top
            }
        }
    }

}
