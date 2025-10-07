shader_type spatial;
//render_mode blend_mix, depth_draw_opaque, depth_test_default, cull_back, diffuse_lambert, specular_schlick_ggx;

//uniform sampler2D tex_vtx_2;
//uniform sampler2D tex_vtx_5;
uniform float time = 0.0;
uniform sampler2D tex_1;
uniform sampler2D tex_2;
uniform vec4 ColorParameter : source_color = vec4(0.000000, 0.266667, 0.533333, 1.000000);
uniform vec2 noise_scale_1;
uniform vec2 noise_scale_2;
uniform float wave_height;
uniform float wave_speed;
uniform float fragment_power = 1.25;
uniform float alpha = 0.95;
uniform float roughness = 0.2;


vec4 wave_noise(vec2 pos){
	vec2 t = vec2(time, time);

// Texture 1
// Texture2D for texture 1
	vec2 tex_coord_1 = pos * noise_scale_1 + t * wave_speed;
	vec4 noise_1 = texture(tex_1, tex_coord_1);

// Texture 2
// Texture2D
	vec2 tex_coord_2 = pos * noise_scale_2 + t * wave_speed;
	vec4 noise_2 = texture(tex_2, tex_coord_2);


// VectorOp:14
	vec4 wave_noise = noise_1 * noise_2;
	return wave_noise;
}


void vertex() {
	vec3 world_pos = (MODEL_MATRIX * vec4(VERTEX, 0.0)).xyz;
	vec4 noise = wave_noise(world_pos.xz);

// VectorOp:10
	vec3 exponent = vec3(fragment_power);
	vec3 c_noise = pow(noise.xyz, exponent);
// VectorOp: Assigning the COLOR prop for fragment funciton
	COLOR = vec4(c_noise, 0.0) + ColorParameter;


// MultiplyAdd: Noise * Normal + vertex, NORMAL just selects the y component
	vec3 noised_vertex = noise.r * NORMAL + VERTEX;
//VERTEX = vec3(VERTEX.x, noise.y * wave_height + VERTEX.y, VERTEX.z)

// Adjusting wave height and outputing:
	VERTEX = noised_vertex * vec3(1.0, wave_height, 1.0);

}


void fragment() {
// Output:0
	ALBEDO = COLOR.xyz; // from vertex
	ALPHA = alpha;
	ROUGHNESS = roughness;
}
