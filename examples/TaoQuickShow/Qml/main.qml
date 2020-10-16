import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0
import "./Page"

//import Qt.labs.platform 1.1
CusBackground {
    id: rootItem
    width: 1440
    height: 900

    //    SystemTrayIcon {
    //        id: sysTray
    //        visible: true
    //        icon.source: imgPath + "logo/milk.png"
    //        menu: Menu {
    //            MenuItem {
    //                text: qsTr("Quit")
    //                onTriggered: {
    //                    Qt.quit()
    //                }
    //            }
    //        }
    //    }
    //    AboutDialog {
    //        id: aboutDialog
    //    }
    //    SettingsDialog {
    //        id: settingDialog
    //    }
    TitlePage {
        id: title
        width: parent.width
        height: 60
    }
    Item {
        id: content
        width: parent.width
        anchors {
            top: title.bottom
            bottom: parent.bottom
        }
        CusFPS {
            anchors {
                right: parent.right
                top: parent.top
            }
        }

        LeftPane {
            id: leftPane
            anchors.fill: parent
        }

        RightPane {
            id: rightPane
            anchors {
                left: leftPane.right
                right: parent.right
            }
            height: parent.height
        }
    }
}
