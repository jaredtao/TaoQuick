import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

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
