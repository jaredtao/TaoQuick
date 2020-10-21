import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

ShaderEffect {
    id: r

    readonly property int directFromLeft: 0
    readonly property int directFromRight: 1
    readonly property int directFromTop: 2
    readonly property int directFromBottom: 3

    property int dir: directFromLeft
    property int duration: 1000
    property ShaderEffectSource effectSource: ShaderEffectSource {
        hideSource: true
    }
    property int percent: 0
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

    fragmentShader: CusEffectCommon.fragmentShaderCommon + "
        varying vec2 qt_TexCoord0;
        uniform float qt_Opacity;
        uniform sampler2D effectSource;
        uniform int dir;
        uniform int percent;
        void main()
        {
            vec4 color = texture2D(effectSource, qt_TexCoord0);
            float p = float(percent) / 100.0f;
            float alpha = 1.0f;

//            if (dir == 0 ) {
//                alpha = 1.0 - step(p, qt_TexCoord0.x);
//            } else if (dir == 1){
//                alpha = 1.0 - step(p, 1.0 - qt_TexCoord0.x);
//            } else if (dir == 2) {
//                alpha = 1.0f - step(p, qt_TexCoord0.y);
//            } else if (dir == 3) {
//                alpha = 1.0f - step(p, 1.0 - qt_TexCoord0.y);
//            }
            //optimize: array replace if else
            float coords[] = float[](qt_TexCoord0.x, 1.0 - qt_TexCoord0.x, qt_TexCoord0.y, 1.0 - qt_TexCoord0.y);
            alpha = 1.0f - step(p, coords[dir]);
            alpha *= qt_Opacity;
            gl_FragColor = vec4(color.rgb * alpha, alpha);
        }
    "

    function restart() {
        animation.restart()
    }
}
