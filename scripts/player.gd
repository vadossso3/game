extends Area2D

const SPEED = 300.0
@export var max_health = 100
var health = 10

signal health_changed(health)

@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	emit_signal("health_changed", health)

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		animated_sprite.play("move right")
	elif Input.is_action_pressed("move_left"):
		velocity.x -= 1
		animated_sprite.play("move left")
	elif Input.is_action_pressed("move_down"):
		velocity.y += 1
		animated_sprite.play("move down")
	elif Input.is_action_pressed("move_up"):
		velocity.y -= 1
		animated_sprite.play("move up")
	else: 
		animated_sprite.play("stay")
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		
	position += velocity * delta

func _on_health_potion_pick_up(heal: Variant) -> void:
	health = min(max_health, health + heal)
	emit_signal("health_changed", health)

func _on_posion_potion_posion_player(damage: Variant) -> void:
	health = max(0, health - damage)
	emit_signal("health_changed", health)
