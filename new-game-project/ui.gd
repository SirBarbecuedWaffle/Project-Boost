extends CanvasLayer

@onready var label: Label = $MarginContainer/CenterContainer/Label


func update_fuel(amt):
	if label!=null:
		label.text="FUEL: "+str(amt)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
