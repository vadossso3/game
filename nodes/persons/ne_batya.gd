extends StaticBody2D
@onready var animated_sprite = $AnimatedSprite2D

signal dialog

var resource

func _ready() -> void:
	animated_sprite.play("chill")
	resource = load("res://assets/dialogs/ne_batya.dialogue")

func _on_dialog():
	DialogueManager.show_dialogue_balloon(resource)
