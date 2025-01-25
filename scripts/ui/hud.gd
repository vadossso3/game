extends CanvasLayer

func _on_player_health_changed(health: int) -> void:
	$Health.text = str(health)
