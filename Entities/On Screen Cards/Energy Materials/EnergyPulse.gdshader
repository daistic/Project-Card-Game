shader_type canvas_item;

uniform vec4 base_color : source_color = vec4(1.0, 0.8, 0.2, 1.0); // main bar color
uniform vec4 glow_color : source_color = vec4(1.0, 1.0, 0.5, 1.0); // glow effect
uniform float glow_strength = 0.4;
uniform float flow_speed = 1.5;
uniform float flow_freq = 6.0;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    COLOR = tex * base_color;

    // 🔹 Flowing highlight
    float flow = sin((UV.y - TIME * flow_speed) * flow_freq);
    flow = smoothstep(0.0, 0.5, flow);
    COLOR.rgb += glow_color.rgb * flow * 0.3;

    // 🔹 Edge glow
    float edge = min(UV.x, 1.0 - UV.x);
    edge = smoothstep(0.05, 0.0, edge);
    COLOR.rgb += glow_color.rgb * edge * glow_strength;
}
