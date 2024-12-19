extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_player_health_changed(health: int) -> void:
	$Health.text = str(health)
