extends Node

var current_scene = null
var spawn_market_name = null
var previous_level_name = null

signal on_trigger_player_spawn

func _ready():
	var root = get_tree().root

	current_scene = root.get_child(-1)

func goto_scene(path):
	_deferred_goto_scene.call_deferred(path)

func _deferred_goto_scene(path):
	previous_level_name = get_tree().root.get_child(-1).name
	current_scene.free()

	var s = ResourceLoader.load(path)

	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene

func trigger_player_spawn(position: Vector2):
	on_trigger_player_spawn.emit(position)
	previous_level_name = get_tree().root.get_child(-1).name
