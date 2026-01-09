extends RigidBody3D
class_name Player
@export_range(750,2500) var launchForce:=1000.0
@export_range(50,200) var turnSpeed:=100.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y*delta*launchForce)
	if Input.is_action_pressed("rot_left"):
		apply_torque(Vector3(0.0,0.0,delta*turnSpeed))
	if Input.is_action_pressed("rot_right"):
		apply_torque(Vector3(0.0,0.0,delta*-1*turnSpeed))


func _on_body_entered(body: Node) -> void:
	if "goal" in body.get_groups():
		if body.file_path!=null:
			complete_level(body.file_path)
		else:
			print("ERROR CODE 002: where tf u tryin to go???")
	if "obstacle" in body.get_groups():
		crash_sequence()

func complete_level(next_level_file)->void:
	get_tree().change_scene_to_file(next_level_file)
	
func crash_sequence()->void:
	print("KABOOM")
	await get_tree().create_timer(2.5).timeoutd
	get_tree().reload_current_scene.call_deferred()
