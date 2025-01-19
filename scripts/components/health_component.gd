extends Node

@export var health: int = 100


signal hit(damage: int)
signal heal(heal: int)
signal dead

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hit.connect(_on_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_hit(hit):
	health -= hit
	
	if health <= 0:
		emit_signal("dead")
