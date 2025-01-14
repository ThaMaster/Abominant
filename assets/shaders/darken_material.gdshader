shader_type canvas_item;

uniform float darken_factor : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    COLOR = tex_color * vec4(vec3(darken_factor), 1.0);
}
