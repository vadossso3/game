extends Area2D

var is_opened = false
@onready var door = $DoorStatic

func interact():
	if !is_opened:
		is_opened = true
		door.rotate(deg_to_rad(90))
	else:
		is_opened = false
		door.rotate(deg_to_rad(-90))
