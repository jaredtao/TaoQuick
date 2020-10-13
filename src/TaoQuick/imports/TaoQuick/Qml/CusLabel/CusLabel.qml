import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."
Label {
    font.pixelSize: Config.fontSize_default
    color: Config.textColor
    height: Config.fixedHeight
    elide: Text.ElideRight
}
