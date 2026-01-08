extends RigidBody3D
class_name Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y*delta*1000)
	if Input.is_action_pressed("rot_left"):
		apply_torque(Vector3(0.0,0.0,delta*100))
	if Input.is_action_pressed("rot_right"):
		apply_torque(Vector3(0.0,0.0,delta*-100))


func _on_body_entered(body: Node) -> void:
	print(body.name)
	print("AAAAAAAAAAAAAAAAAA")
	
