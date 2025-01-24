extends RigidBody2D

@export var speed : int
@export var delay_timer : Timer

@onready var health = $HealthComponent

var target
var can_move : bool

signal dead

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(delay_timer != null, "Setup timer for enemy!")
	assert(health != null, "Setup health component")
	target = get_tree().get_nodes_in_group("player")[0]
	
	delay_timer.timeout.connect(_toggle_movement)
	health.dead.connect(_on_dead)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (can_move):
		var velocity = global_position.direction_to(target.global_position)
		move_and_collide(velocity * speed * delta)

func _toggle_movement():
	can_move = !can_move
	
	if !can_move:
		delay_timer.set_paused(false)
		pass
	
	if can_move:
		delay_timer.set_paused(true)
		pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		_toggle_movement()
		health.emit_signal("deal_damage", 20)
		
func _on_dead():
	queue_free()
