import QtQuick 2.12
import QtQuick.Controls 2.12
/*
vec3        iResolution             image/buffer        The viewport resolution (z is pixel aspect ratio, usually 1.0)
float       iTime                   image/sound/buffer	Current time in seconds
float       iTimeDelta              image/buffer        Time it takes to render a frame, in seconds
int         iFrame                  image/buffer        Current frame
float       iFrameRate              image/buffer        Number of frames rendered per second
float       iChannelTime[4]         image/buffer        Time for channel (if video or sound), in seconds
vec3        iChannelResolution[4]	image/buffer/sound	Input texture resolution for each channel
vec4        iMouse                  image/buffer        xy = current pixel coords (if LMB is down). zw = click pixel
sampler2D	iChannel{i}             image/buffer/sound	Sampler for input textures i
vec4        iDate                   image/buffer/sound	Year, month, day, time in seconds in .xyzw
float       iSampleRate             image/buffer/sound	The sound sample rate (typically 44100)
*/
ShaderEffect {
    id: shader

    //properties for shader

    //not pass to shader
    readonly property vector3d defaultResolution: Qt.vector3d(shader.width, shader.height, shader.width / shader.height)
    function calcResolution(channel) {
        if (channel) {
            return Qt.vector3d(channel.width, channel.height, channel.width / channel.height);
        } else {
            return defaultResolution;
        }
    }
    //pass
    readonly property vector3d  iResolution: defaultResolution
    property real       iTime: 0
    property real       iTimeDelta: 100
    property int        iFrame: 10
    property real       iFrameRate
    property vector4d   iMouse;
    property var iChannel0; //only Image or ShaderEffectSource
    property var iChannel1; //only Image or ShaderEffectSource
    property var iChannel2; //only Image or ShaderEffectSource
    property var iChannel3; //only Image or ShaderEffectSource
    property var        iChannelTime: [0, 1, 2, 3]
    property var        iChannelResolution: [calcResolution(iChannel0), calcResolution(iChannel1), calcResolution(iChannel2), calcResolution(iChannel3)]
    property vector4d   iDate;
    property real       iSampleRate: 44100

    //properties for Qml controller
    property alias hoverEnabled: mouse.hoverEnabled
    property bool running: true
    function restart() {
        shader.iTime = 0
        running = true
        timer1.restart()
    }
    Timer {
        id: timer1
        running: shader.running
        triggeredOnStart: true
        interval: 16
        repeat: true
        onTriggered: {
            shader.iTime += 0.016;
        }
    }
    Timer {
        running: shader.running
        interval: 1000
        onTriggered: {
            var date = new Date();
            shader.iDate.x = date.getFullYear();
            shader.iDate.y = date.getMonth();
            shader.iDate.z = date.getDay();
            shader.iDate.w = date.getSeconds()
        }
    }
    MouseArea {
        id: mouse
        anchors.fill: parent
        onPositionChanged: {
            shader.iMouse.x = mouseX
            shader.iMouse.y = mouseY
        }
        onClicked: {
            shader.iMouse.z = mouseX
            shader.iMouse.w = mouseY
        }
    }
    readonly property string gles2Ver: "
#define texture texture2D
precision mediump float;
"
    readonly property string gles3Ver: "#version 300 es
#define varying in
#define gl_FragColor fragColor
precision mediump float;

out vec4 fragColor;
"

    readonly property string gl3Ver: "#version 150
#define varying in
#define gl_FragColor fragColor
#define lowp
#define mediump
#define highp

out vec4 fragColor;
"
    readonly property string gl2Ver: "#version 110
#define texture texture2D
"
    property string versionString: {
        if (Qt.platform.os === "android") {
            if (GraphicsInfo.majorVersion === 3) {
                console.log("android gles 3")
                return gles3Ver
            } else {
                console.log("android gles 2")
                return gles2Ver
            }
        } else {
            if (GraphicsInfo.majorVersion === 3 ||GraphicsInfo.majorVersion === 4) {
                return gl3Ver
            } else {
                return gl2Ver
            }
        }
    }

    vertexShader: "
              uniform mat4 qt_Matrix;
              attribute vec4 qt_Vertex;
              attribute vec2 qt_MultiTexCoord0;
              varying vec2 qt_TexCoord0;
              varying vec4 vertex;
              void main() {
                  vertex = qt_Vertex;
                  gl_Position = qt_Matrix * vertex;
                  qt_TexCoord0 = qt_MultiTexCoord0;
              }"
    readonly property string forwardString: versionString + "
        varying vec2 qt_TexCoord0;
        varying vec4 vertex;
        uniform lowp   float qt_Opacity;

        uniform vec3   iResolution;
        uniform float  iTime;
        uniform float  iTimeDelta;
        uniform int    iFrame;
        uniform float  iFrameRate;
        uniform float  iChannelTime[4];
        uniform vec3   iChannelResolution[4];
        uniform vec4   iMouse;
        uniform vec4    iDate;
        uniform float   iSampleRate;
        uniform sampler2D   iChannel0;
        uniform sampler2D   iChannel1;
        uniform sampler2D   iChannel2;
        uniform sampler2D   iChannel3;
    "
    readonly property string startCode: "
        void main(void)
        {
            mainImage(gl_FragColor, vec2(vertex.x, iResolution.y - vertex.y));
        }"
    readonly property string defaultPixelShader: "
        void mainImage(out vec4 fragColor, in vec2 fragCoord)
        {
            fragColor = vec4(fragCoord, fragCoord.x, fragCoord.y);
        }"
    property string pixelShader: ""
    fragmentShader: forwardString + (pixelShader ? pixelShader : defaultPixelShader) + startCode
}
