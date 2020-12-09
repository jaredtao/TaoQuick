import QtQuick 2.10
import QtQuick.Controls 2.2
import ".."
import "../.."
Label {
    font.pixelSize: Config.fontSize_default
    color: Config.textColor
    height: Config.fixedHeight
    elide: Text.ElideRight
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
//    renderType: Text.NativeRendering
}
