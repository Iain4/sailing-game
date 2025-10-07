extends Area3D

var material: ShaderMaterial
var time = 0.0
var tex_1
var tex_2
var noise_scale_1: Vector2
var noise_scale_2: Vector2
var wave_height: float
var wave_speed: float

@onready var markers = $Markers.get_children()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	material = $ShaderMesh.mesh.surface_get_material(0)
	time = material.get_shader_parameter("time")
	tex_1 = material.get_shader_parameter("tex_1").noise.get_image(512, 512)
	tex_2 = material.get_shader_parameter("tex_2").noise.get_image(512, 512)
	noise_scale_1 = material.get_shader_parameter("noise_scale_1")
	noise_scale_2 = material.get_shader_parameter("noise_scale_2")
	wave_height = material.get_shader_parameter("wave_height")
	wave_speed = material.get_shader_parameter("wave_speed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# keepin it all synced up
	time += delta
	material.set_shader_parameter("time", time)
	for m in markers:
		var pos = m.position
		m.position = Vector3(pos.x, get_water_height(m.position), pos.z)
	
	
func get_water_height(world_pos: Vector3):
	return material.shader.wave_noise(world_pos)
	
	
func _get_noise_value(
		texture, 
		world_pos: Vector3, 
		noise_scale: Vector2
	) -> float:
	var uv_x = (world_pos.x * noise_scale.x + time * wave_speed)
	var uv_y = (world_pos.z * noise_scale.y + time * wave_speed)
	var pixel_pos = Vector2(uv_x * texture.get_width(), uv_y * texture.get_height())
	return texture.get_pixelv(pixel_pos).r

func get_water_height_1(world_pos: Vector3) -> float:
	var noise_1 = _get_noise_value(tex_1, world_pos, noise_scale_1)
	var noise_2 = _get_noise_value(tex_2, world_pos, noise_scale_2)
	
	return noise_1 * noise_2 * wave_height + position.y
	
