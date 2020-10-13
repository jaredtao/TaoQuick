import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

TextField {
    id: cusTextField
    height: Config.fixedHeight
    hoverEnabled: enabled
    selectByMouse: true
    color: Config.textColor
    maximumLength: Config.maximumLength
    selectionColor: Config.controlBackgroundColor_highlight
    selectedTextColor: Config.controlTextColor_highlight
    property bool invalid: false
    onTextChanged: {
        invalid = false
    }
    background: Rectangle {
        color: (cusTextField.enabled
                && !cusTextField.readOnly) ? Config.controlBackgroundColor : Config.controlBackgroundColor_disabled
        radius: Config.controlBorderRadius
        border.width: 1
        border.color: {
            if (cusTextField.enabled) {
                if (cusTextField.readOnly) {
                    return Config.controlBorderColor
                } else {
                    if (cusTextField.invalid) {
                        return Config.invalidColor
                    } else {
                        if (cusTextField.hovered || cusTextField.focus) {
                            return Config.controlBorderColor_hovered
                        } else {
                            return Config.controlBorderColor
                        }
                    }
                }
            } else {
                return Config.controlBorderColor
            }
        }
    }
}
