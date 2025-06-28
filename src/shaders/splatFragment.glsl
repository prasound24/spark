
precision highp float;
precision highp int;

#include <splatDefines>

uniform bool encodeLinear;
uniform float maxStdDev;
uniform bool disableFalloff;
uniform float falloff;

out vec4 fragColor;

in vec4 vRgba;
in vec2 vSplatUv;
in vec3 vNdc;

void main() {
    float len2 = dot(vSplatUv, vSplatUv);
    float density = mix(1.0, exp(-0.5 * len2), falloff);
    fragColor = vRgba*density;
}
