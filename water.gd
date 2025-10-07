extends Area3D

@export var material: ShaderMaterial

@export var tex_1: NoiseTexture2D
@export var tex_2: NoiseTexture2D

@export var time = 0.0
@export var noise_scale_1: Vector2 = Vector2(0.05, 0.05)
@export var noise_scale_2: Vector2 = Vector2(-0.05, -0.05)
@export var wave_height: float = 10.0
@export var wave_speed: float = 0.05

@onready var markers = $Markers.get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	material = $ShaderMesh.mesh.surface_get_material(0)
	time = material.get_shader_parameter("time")
	
	material.set_shader_parameter("tex_1", tex_1)
	material.set_shader_parameter("tex_2", tex_2)
	
	material.set_shader_parameter("noise_scale_1", noise_scale_1) 
	material.set_shader_parameter("noise_scale_2", noise_scale_2) 
	material.set_shader_parameter("wave_height", wave_height) 
	material.set_shader_parameter("wave_speed", wave_speed) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# keepin it all synced up
	time += delta
	material.set_shader_parameter("time", time)
	
	for m in markers:
		var pos = m.position
		var h = get_water_height(pos)
		m.position = Vector3(pos.x, h, pos.z)
	
#
func get_water_height(pos: Vector3) -> float:
	var p = Vector2(pos.x, pos.z)
	var tex_coord_1 = p * noise_scale_1 + Vector2(time * wave_speed, time * wave_speed)
	var noise_1 = tex_1.noise.get_noise_2dv(tex_coord_1)
	#noise_1 = (noise_1 + 1.0) / 2.0
	
	var tex_coord_2 = p * noise_scale_2 + Vector2(time * wave_speed, time * wave_speed)
	var noise_2 = tex_2.noise.get_noise_2dv(tex_coord_2)
	#noise_2 = (noise_2 + 1.0) / 2.0

	var noise = noise_1 * noise_2 * wave_height
	
	return noise
	
	
	
	

	
