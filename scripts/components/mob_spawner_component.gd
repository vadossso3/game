extends Node2D

@export var spawn_place: CollisionShape2D
@export var spawn_mob: PackedScene

var times = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(spawn_place != null, "add collisition shape")
	assert(spawn_mob != null, "add spawn mob")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(spawn_place.shape.get_rect())
