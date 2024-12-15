extends Area2D

const SPEED = 300.0
var health = 100

signal hit
@onready var animated_sprite = $AnimatedSprite2D

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



func _on_area_entered(area: Area2D) -> void:
	var groups = area.get_groups()
	if groups.has("healthPotion"):
		print_debug("heal")
	if groups.has("posionPotion"):
		print_debug("posion")
