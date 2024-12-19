extends Area2D

var heal = 20

signal healPlayer(heal)

func _ready():
	body_entered.connect(_on_area_entered)

func _on_area_entered(body) -> void:
	if body is CharacterBody2D:
		if body.health != body.max_health:
			emit_signal("healPlayer", heal)
			queue_free()
