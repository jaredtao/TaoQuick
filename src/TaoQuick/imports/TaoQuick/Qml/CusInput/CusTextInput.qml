import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
TextInput {
    id: cusTextField
    height: Config.fixedHeight
    selectByMouse: true
    color: Config.textColor
    maximumLength: Config.maximumLength
    selectionColor: Config.controlBackgroundColor_highlight
    selectedTextColor: Config.controlTextColor_highlight
}
