extends Node2D

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_connectHealthPotions()
	_connectPosionPotions()
	_connectDialogable()
	
func _connectHealthPotions() -> void:
	var healthPotions = get_tree().get_nodes_in_group("healthPotion")
	for potion in healthPotions:
		potion.healPlayer.connect(player._on_health_potion_pick_up)

func _connectPosionPotions() -> void:
	var posionPotions = get_tree().get_nodes_in_group("posionPotion")
	for potion in posionPotions:
		potion.posionPlayer.connect(player._on_posion_potion_posion_player)

func _connectDialogable():
	var dialog_nodes = get_tree().get_nodes_in_group("dialogable")
	
	DialogueManager.dialogue_ended.connect(player._on_dialogue_ended)
	
	for dialog_node in dialog_nodes:
		dialog_node.dialog.connect(dialog_node._on_dialog)
