import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

import ".."
import "../.."

Label {
    font.family: CusConfig.fontFamily
    font.pixelSize: CusConfig.fontPixel
    color: CusConfig.textColor
    elide: Text.ElideRight
//    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignLeft
}
