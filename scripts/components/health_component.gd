extends Node

@export var health: int = 100


signal deal_damage(damage: int)
signal restore_health(heal: int)
signal dead

func _ready() -> void:
	deal_damage.connect(_dial_damage)
	
func _dial_damage(hit):
	health -= hit
	
	if health <= 0:
		emit_signal("dead")
