import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

Label {
    font.family: CusConfig.fontFamily
    font.pixelSize: CusConfig.fontPixel
    color: CusConfig.textColor
    height: CusConfig.fixedHeight
    elide: Text.ElideRight
    renderType: Text.NativeRendering
}
