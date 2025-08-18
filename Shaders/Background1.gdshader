/*
    Improved Procedural Electric Background Shader
    Original by Yui Kinomoto (@arlez80)
    Modified for gradient + multi-color neon + glow
*/
shader_type canvas_item;

uniform vec4 background_color1: source_color = vec4(0.02, 0.02, 0.08, 1.0); // center color
uniform vec4 background_color2: source_color = vec4(0.0, 0.0, 0.0, 1.0);    // edge color

uniform vec4 line_color1: source_color = vec4(0.0, 1.0, 1.0, 1.0); // cyan
uniform vec4 line_color2: source_color = vec4(1.0, 0.0, 1.0, 1.0); // magenta

uniform float line_freq = 9.56;
uniform float height = 0.6;
uniform float speed = 0.8;
uniform vec2 scale = vec2(2.0, 16.0);

uniform float glow_strength = 8.0; // higher = sharper glow

void fragment()
{
    // --- Gradient Background ---
    vec2 uvn = UV * 2.0 - 1.0;       // normalize UV to -1..1
    float radial = length(uvn);      // distance from center
    vec4 grad_color = mix(background_color1, background_color2, radial);

    // --- Line Pattern ---
    vec2 uv = UV * scale;
    float shift = cos(floor(uv.y));
    uv.x += shift;

    float freq = clamp(cos(uv.x * line_freq) * 3.0, 0.0, 1.0) * height;

    float line_dist = abs(freq - mod(uv.y, 1.0));
    float line = exp(-glow_strength * line_dist); // glow instead of harsh edges

    // --- Animated Line Color ---
    vec4 neon_color = mix(line_color1, line_color2, 0.5 + 0.5 * sin(TIME + uv.y * 2.0));

    // --- Final Mix ---
    COLOR = mix(grad_color, neon_color, line * mod(uv.x - TIME * speed * abs(shift), 1.0));
}