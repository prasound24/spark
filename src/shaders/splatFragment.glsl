
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
    float z = dot(vSplatUv, vSplatUv);
    if (z > (maxStdDev * maxStdDev)) {
        discard;
    }

    vec3 rgb = vRgba.rgb; // splat brightness
    float opacity = vRgba.a; // splat opacity
    float density = mix(1.0, exp(-0.5 * z), falloff);

    // Tone mapping should be done at the very end.
    //if (encodeLinear) {
    //    rgb = srgbToLinear(rgb);
    //}

    // WebGL can do this check.
    //if (density*max3(rgb) < MIN_ALPHA) {
    //    discard;
    //}

    // Desired blending function:
    //  output.rgb = splat.rgb*density + background.rgb*(1.0 - opacity*density)
    fragColor = vec4(rgb*density, opacity*density);
}
