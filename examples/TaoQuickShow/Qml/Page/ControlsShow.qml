import QtQuick 2.9
import QtQuick.Controls 2.2
import TaoQuick 1.0

Column {
    anchors.centerIn: parent
    spacing: 10
    Row {
        spacing: 10
        CusButton {
            width: 80
            height: 30
            text: "Hello With Tip"
            tipText: "Hello Button"
        }
        CusButton {
            width: 80
            height: 30
            text: "Hello Disable"
            enabled: false
        }
        CusButton_Gradient {
            width: 80
            height: 30
            text: "Hello Gradient"
            tipText: "Hello Gradient"
        }
    }
    Row {
        spacing: 10
        CusSwitch {}
        CusSwitch {
            checked: true
        }
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
        from: 0
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
