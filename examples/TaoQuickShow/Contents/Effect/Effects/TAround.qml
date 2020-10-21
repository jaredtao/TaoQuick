import QtQuick 2.9
import QtQuick.Controls 2.2

import TaoQuick 1.0


CusShaderToy {
    id: r

    //step 1: hsv color
    //    pixelShader: "
    //vec3 hsv2rgb_smooth( vec3 c )
    //{
    //    return c.z * (1. - c.y * smoothstep(2.,1., abs( mod( c.x*6.+vec3(0,4,2), 6.) -3.) ));
    //}
    //void mainImage( out vec4 fragColor, in vec2 fragCoord )
    //{
    //    vec2 uv = fragCoord.xy / iResolution.xy;

    //    vec3 hsl = vec3( uv.x, 1.0, uv.y );

    //    vec3 rgb = hsv2rgb_smooth( hsl );
    //    fragColor = vec4( rgb, 1.0 );
    //}
    //"

    //step 2: radian
    //    pixelShader: "
    ////reference https://www.shadertoy.com/view/MsS3Wc
    //vec3 hsv2rgb_smooth( vec3 c )
    //{
    //    return c.z * (1. - c.y * smoothstep(2.,1., abs( mod( c.x*6.+vec3(0,4,2), 6.) -3.) ));
    //}

    //void mainImage( out vec4 fragColor, in vec2 fragCoord )
    //{
    //    vec2 uv = fragCoord.xy / iResolution.xy;
    //    vec2 gv = uv - 0.5;
    //    float mask = (atan(gv.x, gv.y) / 3.14 + 1) / 2;
    //    vec3 hsl = vec3( mask, 1.0, uv.y );

    //    vec3 rgb = hsv2rgb_smooth( hsl );
    //    fragColor = vec4( rgb, 1.0 );
    //}
    //"

    //3 ring
    //    pixelShader: "
    ////reference https://www.shadertoy.com/view/MsS3Wc
    //vec3 hsv2rgb_smooth( vec3 c )
    //{
    //    return c.z * (1. - c.y * smoothstep(2.,1., abs( mod( c.x*6.+vec3(0,4,2), 6.) -3.) ));
    //}

    //void mainImage( out vec4 fragColor, in vec2 fragCoord )
    //{
    //    vec2 uv = fragCoord.xy / iResolution.xy;
    //    float d = distance(uv, vec2(0.5,0.5));
    //    float x = sin(15 * d + iTime);
    //    x = clamp(x, 0.0, 1.0);
    //    fragColor = vec4(x, x, x, 1.0);
    //}
    //"
    //step 4: ring round
    //    property real wave: waveSlider.value
    //    property real speed: speedSlider.value
    //    property real ringWidth: ringWidthSlider.value / 100
    //    pixelShader: "
    //uniform float wave;
    //uniform float speed;
    //uniform float ringWidth;
    ////reference https://www.shadertoy.com/view/MsS3Wc
    //vec3 hsv2rgb_smooth( vec3 c )
    //{
    //    return c.z * (1. - c.y * smoothstep(2.,1., abs( mod( c.x*6.+vec3(0,4,2), 6.) -3.) ));
    //}

    //void mainImage( out vec4 fragColor, in vec2 fragCoord )
    //{
    //    vec2 uv = fragCoord.xy / iResolution.xy;
    //    float d = distance(uv, vec2(0.5,0.5));
    //    float x = 1. - step(sin(wave * d - iTime * speed) - ringWidth, 0.);
    //    x = clamp(x, 0.0, 1.0);
    //    fragColor = vec4(x, x, x, 1.0);
    //}
    //"

    //    //step 5: rotation round
    //    property real wave: waveSlider.value
    //    property real speed: speedSlider.value
    //    property real ringWidth: ringWidthSlider.value / 100.0
    //    property real rotationSpeed: (rotationSpeedSlider.value - 50.0) / 5.0
    //    pixelShader: "
    //uniform float wave;
    //uniform float speed;
    //uniform float ringWidth;
    //uniform float rotationSpeed;
    ////reference https://www.shadertoy.com/view/MsS3Wc
    //vec3 hsv2rgb_smooth( vec3 c )
    //{
    //    return c.z * (1. - c.y * smoothstep(2.,1., abs( mod( c.x*6.+vec3(0,4,2), 6.) -3.) ));
    //}

    //void mainImage( out vec4 fragColor, in vec2 fragCoord )
    //{
    //    vec2 uv = fragCoord.xy / iResolution.xy;

    //    vec2 gv = uv - 0.5;
    //    gv = vec2(gv.x * cos(rotationSpeed * iTime) - gv.y * sin(rotationSpeed * iTime), gv.y * cos(rotationSpeed * iTime) + gv.x * sin(rotationSpeed * iTime));
    //    float mask = (atan(gv.x, gv.y) / 3.14 + 1) / 2;
    //    vec3 hsl = vec3( mask, 1.0, uv.y );
    //    vec3 rgb = hsv2rgb_smooth( hsl );
    //    fragColor = vec4( rgb, 1.0 );

    ////    float d = distance(uv, vec2(0.5,0.5));
    ////    float x = 1. - step(sin(wave * d - iTime * speed) - ringWidth, 0.);
    ////    x = clamp(x, 0.0, 1.0);
    ////    fragColor = vec4(x, x, x, 1.0);
    //}
    //"

    //step 6: around
    property real wave
    property real speed
    property real ringWidth
    property real rotationSpeed
    property real holeSmooth
    property real holeSize
    property real colorSaturation
    property real colorValue
    pixelShader: "
uniform float wave;
uniform float speed;
uniform float ringWidth;
uniform float rotationSpeed;
uniform float holeSize;
uniform float holeSmooth;
uniform float colorSaturation;
uniform float colorValue;
//reference https://www.shadertoy.com/view/MsS3Wc
vec3 hsv2rgb_smooth( vec3 c )
{
    return c.z * (1. - c.y * smoothstep(2.,1., abs( mod( c.x*6.+vec3(0,4,2), 6.) -3.) ));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord.xy / iResolution.xy;

    vec2 gv = uv - 0.5;
    gv = vec2(gv.x * cos(rotationSpeed * iTime) - gv.y * sin(rotationSpeed * iTime), gv.y * cos(rotationSpeed * iTime) + gv.x * sin(rotationSpeed * iTime));

    float mask = (atan(gv.x, gv.y) / 3.14 + 1) / 2;

    //circle
    float d = distance(uv, vec2(0.5,0.5));
    float x = 1. - step(sin(wave * d - iTime * speed) - ringWidth, 0.);
    x = clamp(x, 0.0, 1.0);
    vec3 circle = vec3(x,x,x);

    //color
    vec3 hsl = vec3( mask, 1.0, uv.y );
    vec3 rgb = hsv2rgb_smooth( hsl );
    vec3 color = colorValue * 3 * d * mix(vec3(1., 1., 1.), rgb, colorSaturation * (1. - d));
    float holeCol = smoothstep(holeSize, holeSmooth, d);

    fragColor = vec4(circle * rgb * holeCol, 1.0);
}
"


}
