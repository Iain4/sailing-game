extends RigidBody3D

@onready var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var probes = $ProbeContainer.get_children()

var water_level = 0 # will change so this contains the waves later

var boyancy = 2.5 # how floaty each probe is
var submersedness = 0.0 # ratio of how many probes are submersed
var sub_lin_drag = 0.025#Vector3(0.5, 0.01, 0.01)
var sub_angular_drag = 0.025#Vector3(0.1, 0.1, 0.01)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	submersedness = 0
	for p in probes:
		var depth = water_level - p.global_position.y
		if depth > 0:
			submersedness += 1
			if depth > 2:
				depth = 2
			apply_force(Vector3.UP * boyancy * depth, p.global_position)
	submersedness = submersedness / probes.size()


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	state.linear_velocity *= 1 - sub_lin_drag #(Vector3.ONE - sub_lin_drag) 
	state.angular_velocity *= 1 - sub_angular_drag #(Vector3.ONE - sub_angular_drag) 
