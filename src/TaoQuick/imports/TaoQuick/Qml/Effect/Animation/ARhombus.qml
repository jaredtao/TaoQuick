import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

ShaderEffect {
    id: r
    readonly property int directFromInner: 0
    readonly property int directFromOuter: 1
    property int dir: directFromInner
    property int duration: 1000
    property ShaderEffectSource effectSource: ShaderEffectSource {
        hideSource: true
    }
    property int percent
    opacity: percent > 0 ? 1 : 0
    NumberAnimation {
        id: animation
        target: r
        property: "percent"
        from: 0
        to: 100
        alwaysRunToEnd: true
        loops: 1
        duration: r.duration
    }
    fragmentShader: CusEffectCommon.fragmentShaderCommon + (dir === directFromInner ? "
        varying vec2 qt_TexCoord0;
        uniform float qt_Opacity;
        uniform sampler2D effectSource;
        uniform int percent;
        void main()
        {
            vec4 color = texture2D(effectSource, qt_TexCoord0);
            float p = float(percent) / 100.0;
            float alpha = 1.0;
            if (qt_TexCoord0.x + p < qt_TexCoord0.y ||
                qt_TexCoord0.x - p > qt_TexCoord0.y ||
                1.0 - qt_TexCoord0.x + p < qt_TexCoord0.y ||
                1.0 - qt_TexCoord0.x - p > qt_TexCoord0.y
            ) {
                discard;
            }
            gl_FragColor = color;
       }
" : "
        varying vec2 qt_TexCoord0;
        uniform float qt_Opacity;
        uniform sampler2D effectSource;
        uniform int percent;
        void main()
        {
            vec4 color = texture2D(effectSource, qt_TexCoord0);
            float p = 1.0 - float(percent) / 100.0;
            if (qt_TexCoord0.x + p > qt_TexCoord0.y &&
                qt_TexCoord0.x - p < qt_TexCoord0.y &&
                1.0 - qt_TexCoord0.x + p > qt_TexCoord0.y &&
                1.0 - qt_TexCoord0.x - p < qt_TexCoord0.y
            ) {
                discard;
            }
            gl_FragColor = color;
        }
")
    function restart() {
        animation.restart()
    }
}
