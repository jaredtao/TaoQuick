import QtQuick 2.9
import QtQuick.Controls 2.2

import ".."
import "../.."

ShaderEffect {
    id: r
    readonly property int directFromLeftTop: 0
    readonly property int directFromRightTop: 1
    readonly property int directFromLeftBottom: 2
    readonly property int directFromRightBottom: 3
    property int dir: directFromLeftTop
    property int duration: 1000
    property ShaderEffectSource effectSource: ShaderEffectSource {
        hideSource: true
    }
    property int percent
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
     fragmentShader: CusEffectCommon.fragmentShaderCommon + "
        varying vec2 qt_TexCoord0;
        uniform float qt_Opacity;
        uniform sampler2D effectSource;
        uniform int dir;
        uniform int percent;
        void main()
        {
            vec4 color = texture2D(effectSource, qt_TexCoord0);
            float p = float(percent) / 100.0;
            float ps[] = float[](2.0 * p - qt_TexCoord0.x - qt_TexCoord0.y,
                                qt_TexCoord0.y - (1.0 - 2.0 *(1.0 -  p)) - qt_TexCoord0.x,
                                qt_TexCoord0.x + (1.0 - 2.0 * p) - qt_TexCoord0.y,
                                qt_TexCoord0.y - 2.0 * (1.0 - p) + qt_TexCoord0.x);
            float alpha = step(0, ps[dir]);
            float alphas[] = float[](alpha, 1.0 - alpha, 1.0 - alpha, alpha);
            alpha = alphas[dir];
            gl_FragColor = vec4(color.rgb * alpha, alpha);
        }
"
     function restart() {
        animation.restart()
     }
}
