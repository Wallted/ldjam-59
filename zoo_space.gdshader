shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;
uniform sampler2D NOISE_PATTERN;

uniform vec4 color_in : source_color;
uniform float edge_softness : hint_range(0.0, 1.0) = 0.1;

instance uniform float aspect_ratio = 1.0;

void fragment() {
	vec4 screen_texture_color = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR = screen_texture_color * color_in;
	
    vec2 centered_uv = UV - 0.5;
	if (aspect_ratio > 1.0) {
    	centered_uv.y *= aspect_ratio;
	} else {
		centered_uv.x /= aspect_ratio;
	}
    vec2 edge_uv = abs(centered_uv) * 2.0;
    float max_dist = max(edge_uv.x, edge_uv.y);
    
    float alpha = 1.0 - smoothstep(1.0 - edge_softness, 1.0, max_dist);

	vec4 noise_texture = texture(NOISE_PATTERN, UV);
	COLOR.a *= alpha * noise_texture.x;
}
