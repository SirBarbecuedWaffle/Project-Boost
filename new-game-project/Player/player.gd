extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		position.y+=delta
	if Input.is_action_pressed("rot_left"):
		rotation.z+=delta
	if Input.is_action_pressed("rot_right"):
		rotation.z-=delta
