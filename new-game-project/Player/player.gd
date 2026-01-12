extends RigidBody3D
class_name Player
@export_range(750,2500) var launchForce:=1000.0
@export_range(50,200) var turnSpeed:=100.0
var transitioning:=false
@onready var success: AudioStreamPlayer = $success
@onready var explode: AudioStreamPlayer = $explode
@onready var boost: AudioStreamPlayer3D = $boost
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !transitioning:
		if Input.is_action_pressed("boost"):
			apply_central_force(basis.y*delta*launchForce)
			if !boost.playing:
				boost.playing=true
		else:
			if boost.playing:
				boost.playing=false
		if Input.is_action_pressed("rot_left"):
			apply_torque(Vector3(0.0,0.0,delta*turnSpeed))
		if Input.is_action_pressed("rot_right"):
			apply_torque(Vector3(0.0,0.0,delta*-1*turnSpeed))


func _on_body_entered(body: Node) -> void:
	if "goal" in body.get_groups() && !transitioning:
		if body.file_path!=null:
			complete_level(body.file_path)
		else:
			print("ERROR CODE 002: where tf u tryin to go???")
	if "obstacle" in body.get_groups() && !transitioning:
		crash_sequence()

func complete_level(next_level_file)->void:
	transitioning=true
	success.play()
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file(next_level_file)
	
func crash_sequence()->void:
	transitioning=true
	explode.play()
	print("KABOOM")
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene.call_deferred()
