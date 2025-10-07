extends CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shape = $ShaderMesh.mesh.create_trimesh_shape()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	shape = $ShaderMesh.mesh.create_trimesh_shape()
