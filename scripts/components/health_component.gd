extends Node

@export var health: int = 100

signal deal_damage(damage: int)
signal restore_health(heal: int)
signal health_changed(current_health: int)
signal dead

var max_health = health

func _ready() -> void:
	deal_damage.connect(_dial_damage)
	restore_health.connect(_restore_health)
	
func _dial_damage(hit):
	health -= hit
	emit_signal("health_changed", health)
	
	if health <= 0:
		emit_signal("dead")

func _restore_health(heal):
	health = min(max_health, heal + health)
	emit_signal("health_changed", health)
