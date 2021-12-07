import QtQml
import QtQuick
import QtQuick.Controls

import ".."
import "../.."

ShaderEffect {
    property Image source
    property color imageColor
    fragmentShader: CusConfig.importPath + "Basic/cusColorOverlay.frag.qsb"
}
