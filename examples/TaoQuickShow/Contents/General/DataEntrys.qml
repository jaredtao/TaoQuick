import QtQml 2.0
import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

Item {
    anchors.fill: parent

    Column {
        anchors.centerIn: parent
        spacing: 10
        CusLabel {
            text: qsTr("CheckBox") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
        }
        Row {
            spacing: 10
            CusCheckBox {
                text: "unchecked"
            }
            CusCheckBox {
                checked: true
                text: "checked"
            }
            CusCheckBox {
                enabled: false
                text: "disable"
            }
            CusCheckBox {
                enabled: false
                checked: true
                text: "disable & checked"
            }
        }
        Item {
            width: 20
            height: 30
        }
        CusLabel {
            text: qsTr("Switch") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
        }
        Row {
            spacing: 10
            CusSwitch {}
            CusSwitch {
                checked: true
            }
        }
        Item {
            width: 20
            height: 30
        }

        CusLabel {
            text: qsTr("ComboBox") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
        }
        Row {
            spacing: 10
            CusComboBox {
                model: 10
                width: 120
                displayText: qsTr(currentText) + trans.transString
            }
            CusComboBox {
                model: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
                width: 120
                displayText: qsTr(currentText) + trans.transString
            }
            CusComboBox {
                id: comboBox3
                width: 120
                height: 30
                textRole: "name"
                font.pixelSize: 10
                model: holdersType
                Component.onCompleted: {
                    if(comboBoxHasValueRole) {
                        valueRole = "cost"
                    }
                }
            }

            ListModel {
                id: holdersType
                ListElement {
                    name: "Apple"
                    cost: 2.45
                }
                ListElement {
                    name: "Orange"
                    cost: 3.25
                }
                ListElement {
                    name: "Banana"
                    cost: 1.95
                }
            }
        }
        Item {
            width: 20
            height: 30
        }
        CusLabel {
            text: qsTr("Slider") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
        }
        Row {
            spacing: 10
            CusSlider {
                width: 200
                from: 0
                to: 200
            }
            CusSlider_Spin {
                width: 200
                from: 0
                to: 100
            }

        }
        CusSpinBox_HourMinute {
            width: 200
        }
        Item {
            width: 20
            height: 30
        }
        CusLabel {
            text: qsTr("TextInput") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
        }
        Row {
            spacing: 10
            CusTextField {
                width: 200
            }
            CusTextField_Search {
                width: 200
            }
        }

        CusLabel {
            text: qsTr("IPv4") + trans.transString
            wrapMode: Label.WordWrap
            width: 400
        }
        CusIPAddress {
            id: ip
            Component.onCompleted: {
                inputIP("192.168.1.1")
            }
        }
        CusLabel {
            text: "IP Addr: " + (ip.isValid ? ip.ipAddr : "")
        }
    }
}
