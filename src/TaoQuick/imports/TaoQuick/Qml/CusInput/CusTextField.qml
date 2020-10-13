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
    background: Rectangle {
        color: (cusTextField.enabled && !cusTextField.readOnly) ? Config.controlBackgroundColor : Config.controlBackgroundColor_disabled
        radius: Config.controlBorderRadius
        border.width: 1
        border.color: (cusTextField.enabled && !cusTextField.readOnly && (cusTextField.hovered || cusTextField.focus)) ? Config.controlBorderColor_hovered : Config.controlBorderColor
    }

}
