shader_type spatial;

render_mode blend_mix,depth_draw_opaque,cull_disabled,diffuse_burley,specular_schlick_ggx;
uniform vec4 albedo : hint_color;
uniform sampler2D texture_albedo : hint_albedo;
uniform float specular;
uniform float metallic;
uniform float roughness : hint_range(0,1);
uniform float point_size : hint_range(0,128);

uniform vec3 uv1_scale;
uniform vec3 uv1_offset;
uniform vec3 uv2_scale;
uniform vec3 uv2_offset;

uniform vec2 direction = vec2(1.0);
uniform float squash: hint_range(0.0, 2.0) = 1.0;
uniform float offset: hint_range(-0.5, 0.5) = 0.0;

void vertex() {
	float v = abs(VERTEX.y + offset) * squash + direction.x;
}