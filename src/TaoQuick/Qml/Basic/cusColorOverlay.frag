#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;



layout(std140, binding = 0) uniform qt_buf {
        mat4 qt_Matrix;
	float qt_Opacity;

        vec4 imageColor;
}qt_ubuf;

layout(binding = 1) uniform sampler2D source;

void main() {
    vec4 pixelColor = texture(source, qt_TexCoord0);
    vec3 c1 = pixelColor.rgb/max(pixelColor.a, 0.00390625);
    vec3 c2 = qt_ubuf.imageColor.rgb/max(qt_ubuf.imageColor.a, 0.00390625);
    fragColor = vec4(mix(c1, c2, qt_ubuf.imageColor.a) * pixelColor.a, pixelColor.a) * qt_ubuf.qt_Opacity;
}
