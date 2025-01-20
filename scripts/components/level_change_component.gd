extends Area2D

@export var collision_area: CollisionShape2D
@export var level_to: String

func _ready() -> void:
	var scene = get_tree().current_scene.name

	assert(collision_area != null, "Set collision area in scene: " + scene)
	assert(level_to != "", "Set level to in scene: " + scene)
	body_entered.connect(_on_body_entered)

func _on_body_entered(_body: Node2D) -> void:
	get_tree().call_deferred("change_scene_to_file", level_to)
