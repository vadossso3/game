extends Area2D

var damage = 20

signal posionPlayer(damage)

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		emit_signal("posionPlayer", damage)
		queue_free()
