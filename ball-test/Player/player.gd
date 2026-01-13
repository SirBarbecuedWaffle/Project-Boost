extends RigidBody3D
class_name Player
@export_range(750,2500) var launchForce:=1000.0
@export_range(50,200) var turnSpeed:=100.0
var transitioning:=false
@onready var success: AudioStreamPlayer = $success
@onready var explode: AudioStreamPlayer = $explode
@onready var boost: AudioStreamPlayer3D = $boost
@onready var _camera_pivot: Node3D = $camera_pivot
@export_range(0.0, 1.0) var mouse_sensitivity = 0.01
@export var tilt_limit = deg_to_rad(75)
@onready var node_3d: Node3D = $Node3D

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_camera_pivot.rotation.x -= event.relative.y * mouse_sensitivity
		_camera_pivot.rotation.x = clampf(_camera_pivot.rotation.x, -tilt_limit, tilt_limit)
		_camera_pivot.rotation.y += -event.relative.x * mouse_sensitivity
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !transitioning:
		if Input.is_action_pressed("boost"):
			apply_central_force(_camera_pivot.global_basis.x*100)
			apply_central_force(_camera_pivot.global_basis.z*-100)
			
			
		else:
			if boost.playing:
				boost.playing=false
		if Input.is_action_pressed("rot_left"):
			apply_central_force(_camera_pivot.global_basis * Vector3(-1, 0, 0)*50)
		if Input.is_action_pressed("rot_right"):
			apply_central_force(_camera_pivot.global_basis * Vector3(1, 0, 0)*50)


func _on_body_entered(body: Node) -> void:
	#if "goal" in body.get_groups() && !transitioning:
		#if body.file_path!=null:
			#complete_level(body.file_path)
		#else:
			#print("ERROR CODE 002: where tf u tryin to go???")
	#if "obstacle" in body.get_groups() && !transitioning:
		#crash_sequence()
	pass

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
