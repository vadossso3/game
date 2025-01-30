extends StaticBody2D
@onready var animated_sprite = $AnimatedSprite2D

signal dialog

var resource

func _ready() -> void:
	animated_sprite.play("chill")
