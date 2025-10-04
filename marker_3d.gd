extends Marker3D

@export var speed = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		position.z -= speed * delta
	if Input.is_action_pressed("ui_down"):
		position.z += speed * delta
	if Input.is_action_pressed("ui_left"):
		position.x -= speed * delta
	if Input.is_action_pressed("ui_right"):
		position.x += speed * delta
	if Input.is_action_pressed("ui_page_up"):
		position.y += speed * delta
	if Input.is_action_pressed("ui_page_down"):
		position.y -= speed * delta
	
