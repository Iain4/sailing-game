extends Area3D

var material: ShaderMaterial;
var time = 0.0;
var tex_1: NoiseTexture2D;
var tex_2: NoiseTexture2D;
var uv_scale_1: Vector2;
var uv_scale_2: Vector2;
var wave_height: float;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	material = $ShaderMesh.mesh.surface_get_material(0)
	time = material.get_shader_parameter("time");
	tex_1 = material.get_shader_parameter("tex_1");
	tex_2 = material.get_shader_parameter("tex_2");
	wave_height = material.get_shader_parameter("wave_height");
	uv_scale_1 = material.get_shader_parameter("uv_scale_1");
	uv_scale_2 = material.get_shader_parameter("uv_scale_2");

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
