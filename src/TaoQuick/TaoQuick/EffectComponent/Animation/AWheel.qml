import QtQuick 2.12
import QtQuick.Controls 2.12

import "../.."

ShaderEffect {
    id: r
    enum Direct {
        Clockwise = 0,
        CounterClockwise = 1
    }
    property int dir : AWheel.Direct.Clockwise
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
    fragmentShader: TCommon.fragmentShaderCommon + (dir === AWheel.Direct.CounterClockwise ? "
        varying vec2 qt_TexCoord0;
        uniform float qt_Opacity;
        uniform sampler2D effectSource;
        uniform int dir;
        uniform int percent;
        void main()
        {
            vec4 color = texture2D(effectSource, qt_TexCoord0);
            float per = float(percent) / 100.0 * -360.0;
            const vec2 origin = vec2(0.5, 0.5);
            const vec2 a = vec2(0.5, 0.0);
            vec2 c = qt_TexCoord0 - origin;
            float alpha = 0.0;
            if (per >= -180.0) {
                if (qt_TexCoord0.y > 0.5) {
                    if (cos(radians(per))* length(c) * length(a) < dot(c, a)) {
                        alpha = 1.0;
                    }
                }
            } else {
                if (qt_TexCoord0.y < 0.5) {
                    if (cos(radians(per))* length(c) * length(a) > dot(c, a)) {
                        alpha = 1.0;
                    }
                } else {
                    alpha = 1.0;
                }
            }
            alpha *= qt_Opacity;
            gl_FragColor = vec4(color.rgb * alpha, alpha);
       }
" : "
        varying vec2 qt_TexCoord0;
        uniform float qt_Opacity;
        uniform sampler2D effectSource;
        uniform int dir;
        uniform int percent;
        void main()
        {
            vec4 color = texture2D(effectSource, qt_TexCoord0);
            float per = float(percent) / 100.0 * 360.0;
            const vec2 origin = vec2(0.5, 0.5);
            const vec2 a = vec2(0.5, 0.0);
            vec2 c = qt_TexCoord0 - origin;
            float alpha = 0.0;
            if (per <= 180.0) {
                if (qt_TexCoord0.y < 0.5) {
                    if (cos(radians(per))* length(c) * length(a) < dot(c, a)) {
                        alpha = 1.0;
                    }
                }
            } else {
                if (qt_TexCoord0.y > 0.5) {
                    if (cos(radians(per))* length(c) * length(a) > dot(c, a)) {
                        alpha = 1.0;
                    }
                } else {
                    alpha = 1.0;
                }
            }
            alpha *= qt_Opacity;
            gl_FragColor = vec4(color.rgb * alpha, alpha);
       }
")
    function restart() {
        animation.restart()
    }
}
