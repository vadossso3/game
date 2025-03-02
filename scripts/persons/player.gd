extends CharacterBody2D

signal can_interact(status)

@export var offset : Vector2 = Vector2(40, -30)

@onready var animated_sprite = $AnimatedSprite2D
@onready var interact_dialog = $InteractDialog
@onready var health_component = $HealthComponent

const SPEED = 125.0

var model_width: int
var model_height: int
var is_dialog_now = false
var view_direction = "down"

func _ready() -> void:
	can_interact.connect(_toggle_interact_ui)
	LevelChangerGlobal.on_trigger_player_spawn.connect(_on_spawn)

func _physics_process(delta: float) -> void:
	movement_input(delta)

func _on_spawn(new_position: Vector2):
	global_position = new_position

func movement_input(delta: float) -> void:	
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * SPEED
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		if velocity.x > 0:
			animated_sprite.play("move right")
			view_direction = "right"
		elif velocity.x < 0:
			animated_sprite.play("move left")
			view_direction = "left"
		elif velocity.y < 0:
			animated_sprite.play("move up")
			view_direction = "up"
		elif velocity.y > 0:
			animated_sprite.play("move down")
			view_direction = "down"
			
		position += velocity * delta
		move_and_slide()
	else:
		if view_direction == "right":
			animated_sprite.play("stay right")
		if view_direction == "left":
			animated_sprite.play("stay left")
		if view_direction == "up":
			animated_sprite.play("stay up")
		if view_direction == "down":
			animated_sprite.play("stay down")

func _on_health_potion_pick_up(heal: Variant) -> void:
	emit_signal("health_changed", heal)

func _on_posion_potion_posion_player(damage: Variant) -> void:
	emit_signal("health_changed", -damage)

func _stop_movement(_resource):
	set_physics_process(false)
	if view_direction == "right":
		animated_sprite.play("stay right")
	if view_direction == "left":
		animated_sprite.play("stay left")
	if view_direction == "up":
		animated_sprite.play("stay up")
	if view_direction == "down":
		animated_sprite.play("stay down")

func _on_dialogue_ended(_resource):
	is_dialog_now = false
	set_physics_process(true)

func _toggle_interact_ui(status):
	interact_dialog.visible = status
