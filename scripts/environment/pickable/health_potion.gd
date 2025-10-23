extends Area2D

@onready var animation_player = $AnimationPlayer
@export var heal = 20

func _ready():
	body_entered.connect(_on_area_entered)

func _on_area_entered(body) -> void:
	if body is CharacterBody2D and body.health_component.max_health != body.health_component.health:
		body.health_component.emit_signal("restore_health", heal)
		animation_player.play("pickup")
