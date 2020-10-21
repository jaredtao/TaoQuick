import QtQuick 2.9
import QtQuick.Controls 2.2

import TaoQuick 1.0


CusShaderToy {
    anchors.fill: parent
    pixelShader:"
// srtuss, 2018
//
// This began as an elaborate soundshader-experiment. I tried to create very clear-sounding
// instruments and mix them nicely, with a feel of depth and dark atmosphere to it. I added
// visuals based the images this music spawns in my head. Hope you enjoy it. :)
//
// Here is a recording of how the shader sounds, on the computers i created/tested it on:
// http://srtuss.thrill-project.com/art/sanctuary_soundtrack.ogg
//
// Music production with a soundshader: :)
// http://srtuss.thrill-project.com/music/shader.ogg
//

vec2 rotate(vec2 p, float a)
{
    float co = cos(a), si = sin(a);
    return p * mat2(co, si, -si, co);
}

vec2 scene(vec3 p, bool details)
{
    float v = 1e38;

    float wall = 3. - dot(vec2(abs(p.x), p.y), normalize(vec2(1., .3)));
    float floorr = p.y;
    v = min(v, wall);
    float srs = .8;
    float strut = max(wall - .5, abs(fract(p.z * srs) - .5) / srs - .1);
    v = min(v, strut);
    v = min(v, max(strut, floorr) - .1);

    v = min(v, max(strut - .1, abs(floorr - 2.) - .5));

    float hole = 1.2 - length(p.xz);
    v = min(v, max(floorr, hole));
    v = min(v, max(abs(floorr), abs(hole)) - .2);

    vec3 q = p + vec3(0., sin(iTime) * .1 - 1., 0.);
    float sphere = length(q) - .4;

    v = min(v, sphere);

    return vec2(v, step(sphere, v));
}

vec3 normal(vec3 p)
{
    float c = scene(p, true).x;
    vec2 h = vec2(.005, 0.);
    return normalize(vec3(scene(p + h.xyy, true).x - c, scene(p + h.yxy, true).x - c, scene(p + h.yyx, true).x - c));
}

vec4 trip(sampler2D sampler, vec3 nml, vec3 pos)
{
    vec3 b = abs(nml);
    b = pow(b, vec3(50.));
    b /= dot(b, vec3(1.));
    return texture(iChannel0, pos.yz) * b.x + texture(iChannel0, pos.xz) * b.y + texture(iChannel0, pos.xy) * b.z;
}

float softshadow( in vec3 ro, in vec3 rd, float mint, float k )
{
    float res = 1.0;
    float t = mint;
    for(int i = 0; i < 32; ++i)
    {
        float h = scene(ro + rd * t, false).x;
        if(h < 0.001)
            return 0.0;
        res = min(res, k * h / t);
        t += h;
    }
    return res;
}

float amb_occ(vec3 p, float h)
{
    float acc = 0.0;
    acc += scene(p + vec3(-h, -h, -h), false).x;
    acc += scene(p + vec3(-h, -h, +h), false).x;
    acc += scene(p + vec3(-h, +h, -h), false).x;
    acc += scene(p + vec3(-h, +h, +h), false).x;
    acc += scene(p + vec3(+h, -h, -h), false).x;
    acc += scene(p + vec3(+h, -h, +h), false).x;
    acc += scene(p + vec3(+h, +h, -h), false).x;
    acc += scene(p + vec3(+h ,+h, +h), false).x;
    return acc / h;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord / iResolution.xy;
    uv = uv * 2. - 1.;
    uv.x *= iResolution.x / iResolution.y;

    vec3 rd = normalize(vec3(uv, 1.66));
    vec3 ro = vec3(0., 1., -2.);
    float tilt = sin(iTime * .1 + 1.5) * .2 + .2;
    ro.yz = rotate(ro.yz, tilt);
    rd.yz = rotate(rd.yz, tilt);

    ro.xz = rotate(ro.xz, sin(iTime * .1) * .5);
    rd.xz = rotate(rd.xz, sin(iTime * .1) * .5);

    float d = 0.;
    for(int i = 0; i < 60; ++i)
    {
        d += scene(ro + rd * d, false).x;
    }

    vec3 hit = ro + rd * d;
    vec3 nml = normal(hit);

    vec3 lpos1 = vec3(0.5, 2., 4.);

    float mtl = scene(hit, false).y;
    vec3 diffMap = vec3(0.);
    if(mtl < .5)
    {
        float k = .001;
        diffMap = trip(iChannel0, nml, hit * 1.111).xyz;
        vec3 diffMap2 = trip(iChannel0, nml, hit * 1.111 + vec3(.005)).xyz;
        nml = normalize(nml + (diffMap.x - diffMap2.x) * .7);
    }
    else
    {
        vec3 mov = hit + vec3(0., sin(iTime) * .1 - 1., 0.);
        //nml = normalize(nml + sin(hit * 200.) * .03);

        float k = .001;
        diffMap = trip(iChannel0, nml, mov * 1.111).xyz;
        vec3 diffMap2 = trip(iChannel0, nml, mov * 1.111 + vec3(.005)).xyz;
        nml = normalize(nml + (diffMap.x - diffMap2.x) * .7);
    }

    vec3 col = vec3(0.);// * exp(length(hit.xy - vec2(0., 1.)) * -1.) * exp(d * -.3);

    for(int i = 0; i < 2; ++i)
    {
        vec3 light = i == 1 ? lpos1 : vec3(cos(iTime * .4), 2., sin(iTime) + 1.);
        vec3 vLight = light - hit;
        vec3 lcol = i == 1 ? vec3(1, 1., .7) : vec3(.3, .7, 1.);
        float lfade = exp(length(vLight) * -1.3);
        vec3 diff = max(dot(nml, normalize(vLight)), 0.) * lfade * lcol;
        vec3 ref = reflect(rd, nml);
        float spec = pow(max(0., dot(normalize(vLight), ref)), 32.);

        vec3 ccol = vec3(1.);
        ccol *= pow(diffMap, vec3(2.));

        ccol *= diff;
        ccol += vec3(.4) * spec * lfade;

        col += ccol;
    }

    col *= smoothstep(-5., 1., amb_occ(hit, .15));

    //col = nml * .5 + .5;

    col += exp((7. - dot(rd, lpos1 - ro)) * -6.);// * softshadow(ro, normalize(lpos1 - ro), .1, 128.);

    float pt = iTime * .2;
    for(int i = 0; i < 20; ++i)
    {
        float pd = 2.;
        hit = ro + rd * pd;
        float h = float(i);
        if(d > pd)
        {
            col += exp(length(hit.xy - vec2(sin(h) * .4 + sin(pt + h) * .1, cos(pt + h) * .1 + fract(pt * .1 + cos(h)))) * -400.) * .05 * (1.1 + sin(h * 10.));
        }
    }

    col = sqrt(col);
    col *= 2.9;

    fragColor = vec4(col,1.0);
}
"
    iChannel0: Image {
        source: contentsPath + "ShaderEffect/Planet1.png"
    }
}
