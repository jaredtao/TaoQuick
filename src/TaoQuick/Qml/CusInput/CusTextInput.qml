import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
TextInput {
    id: cusTextField
    height: CusConfig.fixedHeight
    font.pixelSize: CusConfig.fontPixel
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    selectByMouse: true
    color: CusConfig.textColor
    maximumLength: CusConfig.maximumLength
    selectionColor: CusConfig.controlColor_pressed
    selectedTextColor: CusConfig.textColor_pressed
//    renderType: Text.NativeRendering
}
