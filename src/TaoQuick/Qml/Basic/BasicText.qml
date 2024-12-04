import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import ".."
import "../.."

Text {
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    font.family: CusConfig.fontFamily
    font.pixelSize: CusConfig.fontPixel
    elide: Text.ElideRight
    color: CusConfig.textColor
//    renderType: Text.NativeRendering
}
