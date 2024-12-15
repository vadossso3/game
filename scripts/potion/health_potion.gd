extends Area2D

var heal = 20

signal healPlayer(heal)

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		emit_signal("healPlayer", heal)
		queue_free()
