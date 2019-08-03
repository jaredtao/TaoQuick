import QtQuick 2.12
import QtQuick.Controls 2.12

import "../.."

ShaderEffect {
    id: r
    enum Direct {
        Horizon = 0,
        Vertical = 1,
        HorizonReverse = 2,
        VerticalReverse = 3
    }

    property int dir: ALouver.Direct.Horizon

    property int count: 4
    property int duration: 1000
    property ShaderEffectSource effectSource: ShaderEffectSource {
        hideSource: true
    }
    property int percent
    readonly property int perLen: 100
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
        uniform int perLen;
        uniform int count;
        void main()
        {
            vec4 color = texture2D(effectSource, qt_TexCoord0);
            int len = 0;
            float coords[] = float[](qt_TexCoord0.x, qt_TexCoord0.y, qt_TexCoord0.x, qt_TexCoord0.y);
            int percents[] = int[](percent, percent, perLen - percent, perLen - percent);
            len = int(coords[dir]* float(perLen) * float(count));
            float alpha =  float(step(percents[dir], mod(len, perLen)));
            float alphas[] = float[](1.0 - alpha, 1.0 - alpha, alpha, alpha);
            alpha = qt_Opacity * alphas[dir];
            gl_FragColor = vec4(color.rgb * alpha, alpha);
        }
    "

    function restart() {
        animation.restart()
    }

}
