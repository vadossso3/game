extends Node2D

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_connectHealthPotions()
	_connectPosionPotions()
	
func _connectHealthPotions() -> void:
	var healthPotions = get_tree().get_nodes_in_group("healthPotion")
	for potion in healthPotions:
		potion.healPlayer.connect(player._on_health_potion_pick_up)

func _connectPosionPotions() -> void:
	var posionPotions = get_tree().get_nodes_in_group("posionPotion")
	for potion in posionPotions:
		potion.posionPlayer.connect(player._on_posion_potion_posion_player)
