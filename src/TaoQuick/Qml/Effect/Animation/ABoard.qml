import QtQuick 2.9
import QtQuick.Controls 2.2
import ".."
import "../.."

ShaderEffect {
    id: r
    readonly property int directToRight: 0
    readonly property int directToBottom: 1
    property int dir : directToRight
    property int rowCount: 10
    property int columnCount: 10
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
    fragmentShader: CusEffectCommon.fragmentShaderCommon + (dir === directToRight ? "
        varying  vec2 qt_TexCoord0;
        uniform float qt_Opacity;
        uniform sampler2D effectSource;
        uniform int dir;
        uniform int percent;
        uniform int rowCount;
        uniform int columnCount;
        void main()
        {
            vec4 color = texture2D(effectSource, qt_TexCoord0);
            int xlen = 100 / columnCount;
            int ylen = 100 / rowCount;
            float p = float(percent) / 100.0;
            int x = int(qt_TexCoord0.x * 100.0);
            int y = int(qt_TexCoord0.y * 100.0);
            float alpha = 0.0;
            int sx = x / xlen;
            int sy = y / ylen;
            int xOffset = 0;
            if (sy % 2 != 0) {
                xOffset = xlen / 2;
            }
            if (sx * xlen <= x + xOffset && (x + xOffset) % xlen <= int(float(xlen) * p) ) {
                alpha = 1.0;
            }
            alpha *= qt_Opacity;
            gl_FragColor = vec4(color.rgb * alpha, alpha);
       }
" : "
        varying  vec2 qt_TexCoord0;
        uniform float qt_Opacity;
        uniform sampler2D effectSource;
        uniform int dir;
        uniform int percent;
        uniform int rowCount;
        uniform int columnCount;
        void main()
        {
            vec4 color = texture2D(effectSource, qt_TexCoord0);
            int xlen = 100 / columnCount;
            int ylen = 100 / rowCount;
            float p = float(percent) / 100.0;
            int x = int(qt_TexCoord0.x * 100.0);
            int y = int(qt_TexCoord0.y * 100.0);
            float alpha = 0.0;
            int sx = x / xlen;
            int sy = y / ylen;
            int yOffset = 0;
            if (sx % 2 != 0) {
                yOffset = ylen / 2;
            }
            if (sy * ylen <= y + yOffset && (y + yOffset) % ylen <= int(float(ylen) * p) ) {
                alpha = 1.0;
            }
            alpha *= qt_Opacity;
            gl_FragColor = vec4(color.rgb * alpha, alpha);
       }
")
    function restart() {
        animation.restart()
    }
}
