import QtQml
import QtQuick
import QtQuick.Controls

import ".."
import "../.."

ShaderEffect {
    id: cusColorOverlay
    property Image source
    property color imageColor
    fragmentShader: CusConfig.importPath + "Basic/cusColorOverlay.frag.qsb"
}
