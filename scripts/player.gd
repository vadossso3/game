extends CharacterBody2D

const SPEED = 125.0
@export var max_health = 100
@export var offset : Vector2 = Vector2(40, -30)
var health = 100

signal health_changed(health)

@onready var animated_sprite = $AnimatedSprite2D
@onready var interact_dialog = $InteractDialog

var model_width: int
var model_height: int
var ray: RayCast2D


func _ready() -> void:
	emit_signal("health_changed", health)
	
	var size = $CollisionShape2D.shape.size
	model_width = size[0]
	model_height = size[1]
	ray = $RayCast2D
	ray.target_position = Vector2(model_width * 0.9, 0)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action") and ray.is_colliding():
		var collider = ray.get_collider()
		if ray.get_collider().is_in_group("interactable"):
			collider.interact()

func _physics_process(delta: float) -> void:
	movement_input(delta)
	
	if ray.is_colliding():
		interact_dialog.visible = true
	else:
		interact_dialog.visible = false
	
func movement_input(delta: float) -> void:	
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * SPEED

	if Input.is_anything_pressed() == false: 
		animated_sprite.play("stay")
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED

	if velocity.x > 0:
		animated_sprite.play("move right")
		ray.target_position = Vector2(model_width * 0.9, 0)
	elif velocity.x < 0:
		animated_sprite.play("move left")
		ray.target_position = Vector2(-model_width * 0.9, 0)
	elif velocity.y < 0:
		animated_sprite.play("move up")
		ray.target_position = Vector2(0, -model_height * 0.6)
	elif velocity.y > 0:
		animated_sprite.play("move down")
		ray.target_position = Vector2(0, +model_height * 0.6)
		
	position += velocity * delta
	move_and_slide()

func _on_health_potion_pick_up(heal: Variant) -> void:
	health = min(max_health, health + heal)
	emit_signal("health_changed", health)

func _on_posion_potion_posion_player(damage: Variant) -> void:
	health = max(0, health - damage)
	emit_signal("health_changed", health)
