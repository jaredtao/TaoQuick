#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(binding = 1) uniform sampler2D source;

layout(std140, binding = 0) uniform buf {
        mat4 qt_Matrix;
	float qt_Opacity;
	vec4 imageColor;
}ubuf;

void main() {
    vec4 pixelColor = texture(source, qt_TexCoord0);
    fragColor = vec4(mix(pixelColor.rgb/max(pixelColor.a, 0.00390625), ubuf.imageColor.rgb/max(ubuf.imageColor.a, 0.00390625), ubuf.imageColor.a) * pixelColor.a, pixelColor.a) * ubuf.qt_Opacity;
}
