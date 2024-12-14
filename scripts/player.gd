extends Area2D

const SPEED = 300.0

signal hit

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
	
	position += velocity * delta


func _on_area_entered(area: Area2D) -> void:
	var groups = area.get_groups()
	if groups.has("healthPotion"):
		print_debug("heal")
	if groups.has("posionPotion"):
		print_debug("posion")
