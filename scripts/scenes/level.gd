extends Node2D

signal show_dialogue(dialogue_title)

@export var resourse_path: String

@onready var player = $Player

var resource

func _ready() -> void:
	assert(resourse_path != null, "Add path to dialogue file 'assets/dialogs'")
	
	resource = load(resourse_path)
	
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
	
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	show_dialogue.connect(_show_dialogue)
	show_dialogue.connect(player._stop_movement)
	
	for dialog_node in dialog_nodes:
		DialogueManager.dialogue_ended.connect(dialog_node._on_dialogue_ended)

func _show_dialogue(title):
	DialogueManager.show_dialogue_balloon(resource, title)

func _on_dialogue_ended(_resource):
	player.set_physics_process(true)
