import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0
import "./Page"

//import Qt.labs.platform 1.1
Rectangle {
    id: rootItem
    width: 1440
    height: 900
    color: CusConfig.backgroundColor
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

    //    TitlePage {
    //        id: title
    //        width: parent.width
    //        height: 60
    //        color: gConfig.themeColor
    //    }
    //    Rectangle {
    //        id: content
    //        width: parent.width
    //        anchors {
    //            top: title.bottom
    //            bottom: parent.bottom
    //        }
    //        color: gConfig.background
    //        CusFPS {
    //            anchors {
    //                right: parent.right
    //                top: parent.top
    //            }
    //        }
    //    }
    Column {
        anchors.centerIn: parent
        spacing: 10
        Button {
            id: btn

            width: 80
            height: 30
            text: "Hello"
            BasicTooltip {
                visible: btn.hovered
                text: "Hello Button "
            }
        }
        CusButton {
            width: 80
            height: 30
            text: "Hello"
            tipText: "Hello Button "
        }
        CusButton {
            width: 80
            height: 30
            text: "Hello"
            enabled: false
        }
        CusButton_Gradient {
            width: 80
            height: 30
            text: "Hello"
        }
        CusSwitch {}
        CusCheckBox {}
        CusCheckBox {
            text: "Checked"
        }
        CusComboBox {
            model: 10
            width: 120
        }
        CusSlider {
            width: 200
            from: 0
            to: 200
        }
        CusSlider_Spin {
            width: 200
            from:0
            to: 100
        }
        CusSpinBox_HourMinute {
            width: 200
        }
        CusTextField {
            width: 200
        }
        CusTextField_Search {
            width: 200
        }
    }
}
