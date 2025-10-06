extends Area3D

@onready var shape = HeightMapShape3D
@export var width = 20
@export var depth = 20 # not acctually how deap the sea is at some point
var period = 1

func array_index_2d(row, col, num_rows=width, num_cols=depth) -> int:
	return row * num_cols + col * num_rows
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$WaveCollision.shape.map_width = width
	$WaveCollision.shape.map_depth = depth

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#for row in range(width):
		#for col in range(depth):
	for i in range($WaveCollision.shape.map_data.size()):
		$WaveCollision.shape.map_data.set(
			i,
			sin(i + delta*period)*10
		)
