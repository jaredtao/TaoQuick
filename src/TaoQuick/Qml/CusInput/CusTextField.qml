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
    font.pixelSize: CusConfig.fontPixel
    background: Rectangle {
        color: (cusTextField.enabled && !cusTextField.readOnly) ? CusConfig.controlColor : CusConfig.controlColor_disabled
        radius: CusConfig.controlBorderRadius
        border.width: 1
        border.color: (cusTextField.enabled && !cusTextField.readOnly && (cusTextField.hovered || cusTextField.focus)) ? CusConfig.controlBorderColor_hovered : CusConfig.controlBorderColor
    }
}
