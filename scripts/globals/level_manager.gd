extends Node

signal level_changed

@onready var player: CharacterBody2D = get_tree().get_nodes_in_group("player")[0]

func _ready() -> void:
	print(player.get_node("Camera2D"))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
