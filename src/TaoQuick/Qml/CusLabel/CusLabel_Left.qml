import QtQuick 2.10
import QtQuick.Controls 2.2
import ".."
import "../.."
Label {
    font.pixelSize: CusConfig.fontPixel
    color: CusConfig.textColor
    height: CusConfig.fixedHeight
    elide: Text.ElideRight
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignLeft
//    renderType: Text.NativeRendering
}
