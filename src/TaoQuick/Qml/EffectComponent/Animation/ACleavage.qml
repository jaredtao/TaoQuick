import QtQuick 2.12
import QtQuick.Controls 2.12

import "../.."

ShaderEffect {
    id: r
    enum Direct {
        HorizonToInner = 0,
        HorizonToOuter = 1,
        VerticalToInner = 2,
        VerticalToOuter = 3
    }
    property int dir : ASquare.ACleavge.HorizonToInner
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
    fragmentShader: TCommon.fragmentShaderCommon + "
        varying vec2 qt_TexCoord0;
        uniform float qt_Opacity;
        uniform sampler2D effectSource;
        uniform int dir;
        uniform int percent;
        void main()
        {
            vec4 color = texture2D(effectSource, qt_TexCoord0);
            float p = float(percent) / 200.0;
            float alphas[] = float[]((1.0 - step(p, qt_TexCoord0.x)) + (step(1.0 - p, qt_TexCoord0.x)),
                1.0 - ((1.0 - step(0.5 - p, qt_TexCoord0.x)) + (step(0.5 + p, qt_TexCoord0.x))),
                (1.0 - step(p, qt_TexCoord0.y)) + (step(1.0 - p, qt_TexCoord0.y)),
                1.0 - ((1.0 - step(0.5 - p, qt_TexCoord0.y)) + (step(0.5 + p, qt_TexCoord0.y))));
            float alpha = alphas[dir] * qt_Opacity;
            gl_FragColor = vec4(color.rgb * alpha, alpha);
       }
"
    function restart() {
        animation.restart()
    }
}
