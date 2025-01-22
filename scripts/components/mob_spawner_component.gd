extends Node2D

@export var spawn_place: CollisionShape2D
@export var mob: PackedScene
@export var max_mobs_count = 3
@export var mob_group: String

@onready var spawn_timer = $SpawnerTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(spawn_place != null, "add collisition shape")
	assert(mob != null, "add spawn mob")
	
	spawn_timer.timeout.connect(_timer_mob_spawn)

func _spawn_mob():
	var circle_radius : float = spawn_place.shape.get_rect().size.x / 2.0 # Or y, they are the same in your example
	var random_position_in_circle = _get_random_point_in_circle(circle_radius)
	
	var new_mob = mob.instantiate()
	add_child(new_mob)
	new_mob.global_position = spawn_place.global_position + random_position_in_circle

func _get_random_point_in_circle(radius: float) -> Vector2:
	# Generate random angle in radians
	var angle = randf() * 2.0 * PI
	
	# Generate a random distance from the center within the circle radius
	var distance = radius * sqrt(randf()) 
	
	# Convert polar coordinates to cartesian
	var x = distance * cos(angle)
	var y = distance * sin(angle)
	
	return Vector2(x, y)
	
func _timer_mob_spawn():
	var mob_count = get_tree().get_node_count_in_group(mob_group)
	
	if max_mobs_count > mob_count:
		_spawn_mob()
