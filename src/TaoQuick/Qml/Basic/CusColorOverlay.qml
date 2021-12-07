import QtQml
import QtQuick
import QtQuick.Controls

import ".."
import "../.."

ShaderEffect {
    property Image source
    property color imageColor
    fragmentShader: CusConfig.importPath + "/TaoQuick/Qml/Basic/cusColorOverlay.frag.qsb"
}
