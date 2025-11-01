extends Node2D

signal show_dialogue(dialogue_title)

@export var resourse_path: String

@onready var player = $Player
@onready var HUD = $HUD

var resource

func _ready() -> void:
	resource = load(resourse_path)
	
	_connectDialogable()
	_connectPlayerToHUD()
	
	if LevelChangerGlobal.previous_level_name != null:
		_on_level_spawn()

func _on_level_spawn():
	var levels_path = "Levels/" + LevelChangerGlobal.previous_level_name
	var level_change_component = get_node(levels_path) as Node2D
	LevelChangerGlobal.trigger_player_spawn(level_change_component.spawn_marker.global_position)

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

func _connectPlayerToHUD():
	player.health_component.health_changed.connect(HUD._on_player_health_changed)
	player.health_component.emit_signal("health_changed", player.health_component.health)
