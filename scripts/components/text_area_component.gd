extends Node2D

@export var text_area: CollisionShape2D
@export var dialogue_title: String
@export var one_time = true
@export_enum("Must Enter", "Must Activate") var interact_type: int

var resource
var is_player_entered
var is_dialogue_started = false

func _ready() -> void:
	assert(text_area != null, "Add area 2d with collision")
	assert(dialogue_title != null, "Add dialogue title for component")

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		is_player_entered = true
		
		if interact_type == 0:
			_show_dialogue()
		if interact_type == 1:
			body.emit_signal("can_interact", true)

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		is_player_entered = false
		if interact_type == 1:
			body.emit_signal("can_interact", false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action") and is_player_entered and !is_dialogue_started:
		if interact_type == 1:
			_show_dialogue()
			is_dialogue_started = true

func _show_dialogue() -> void:
	get_tree().get_current_scene().emit_signal("show_dialogue", dialogue_title)
	
	if one_time:
		_destroy()

func _on_dialogue_ended(_resource):
	is_dialogue_started = false
	


func _destroy() -> void:
	call_deferred("queue_free")
