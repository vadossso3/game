extends Area2D

@export var collision_area: CollisionShape2D
@export var level_to_path: String
@export var spawn_marker: Marker2D

func _ready() -> void:
	assert(collision_area != null, "Set collision area in scene")
	assert(level_to_path != "", "Set level to in scene")
	assert(spawn_marker != null, "Set spawn marker")

	body_entered.connect(_on_body_entered)

func _on_body_entered(_body: Node2D) -> void:
	LevelChangerGlobal.goto_scene(level_to_path)
