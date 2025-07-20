shader_type canvas_item;

uniform float alpha : hint_range(0.0, 1.0) = 0.2;
uniform float inner_radius : hint_range(0.0, 1.0) = 0.45;
uniform float outer_radius : hint_range(0.0, 1.0) = 0.75;

void fragment() {
    float dist = distance(UV, vec2(0.5));
    float vignette = smoothstep(inner_radius, outer_radius, dist);
    COLOR = vec4(0, 0, 0, vignette * alpha);
}
