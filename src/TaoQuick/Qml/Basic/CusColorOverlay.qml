import QtQml
import QtQuick
import QtQuick.Controls
ShaderEffect {
    property Image source
    property color imageColor
    fragmentShader: "cusColorOverlay.qsb"
}
