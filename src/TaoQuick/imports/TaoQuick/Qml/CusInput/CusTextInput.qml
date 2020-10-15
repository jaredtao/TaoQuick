import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
TextInput {
    id: cusTextField
    height: CusConfig.fixedHeight
    selectByMouse: true
    color: CusConfig.textColor
    maximumLength: CusConfig.maximumLength
    selectionColor: CusConfig.controlColor_pressed
    selectedTextColor: CusConfig.textColor_pressed
}
