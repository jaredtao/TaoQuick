import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

TextField {
    id: cusTextField
    height: CusConfig.fixedHeight
    hoverEnabled: enabled
    selectByMouse: true
    color: CusConfig.textColor
    maximumLength: CusConfig.maximumLength
    selectionColor: CusConfig.controlColor_pressed
    selectedTextColor: CusConfig.textColor_pressed
    property bool invalid: false
    onTextChanged: {
        invalid = false
    }
    background: Rectangle {
        color: (cusTextField.enabled
                && !cusTextField.readOnly) ? CusConfig.controlColor : CusConfig.controlColor_disabled
        radius: CusConfig.controlBorderRadius
        border.width: 1
        border.color: {
            if (cusTextField.enabled) {
                if (cusTextField.readOnly) {
                    return CusConfig.controlBorderColor
                } else {
                    if (cusTextField.invalid) {
                        return CusConfig.invalidColor
                    } else {
                        if (cusTextField.hovered || cusTextField.focus) {
                            return CusConfig.controlBorderColor_hovered
                        } else {
                            return CusConfig.controlBorderColor
                        }
                    }
                }
            } else {
                return CusConfig.controlBorderColor
            }
        }
    }
}
