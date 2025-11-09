extends StaticBody2D

@onready var interact_area = $Area2D
@onready var ui = %ui
@onready var hand = %hand
@onready var marihuana = %marihuanas
@onready var trash = %trash

var is_player_entered = false
var is_fist_overlap: bool = false
var is_dragging: bool = false
var arm
var overlapObject: Control
var screen_size: Rect2

func _ready() -> void:
	interact_area.body_entered.connect(_on_body_entered)
	interact_area.body_exited.connect(_on_body_exited)

	ui.visible = false
	arm = hand.get_node("fist")
	screen_size = get_viewport_rect()

func _process(_delta: float) -> void:
	if ui.visible:
		move_hand()

	if is_fist_overlapping_marihuna():
		arm.color = Color(0.0, 0.481, 0.679)
	else:
		arm.color = Color(0.542, 0.433, 0.0)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		is_player_entered = true
		body.emit_signal("can_interact", true)

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		is_player_entered = false
		body.emit_signal("can_interact", false)

func _input(event: InputEvent) -> void:
	# открытие стола
	if event.is_action_pressed("action") and is_player_entered and not ui.visible:
		_interact()
	
	# перетаскивание рукой
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and is_fist_overlap:
				is_dragging = true
				print("drag")
			if !event.pressed and is_dragging:
				is_dragging = false
				overlapObject.global_position.x = clamp(overlapObject.global_position.x, screen_size.position.x, screen_size.end.x - overlapObject.size.x)
				overlapObject.global_position.y = clamp(overlapObject.global_position.y, screen_size.position.y, screen_size.end.y - overlapObject.size.y)
				if is_drop_to_trash():
					overlapObject.remove_from_group("draggable")

func _interact():
	ui.visible = true

func _on_button_pressed() -> void:
	ui.visible = false

func is_fist_overlapping_marihuna():
	var armRect = Rect2(arm.global_position, arm.size)

	for child in get_tree().get_nodes_in_group("draggable"):
		if child is Control:
			var childRect = Rect2(child.global_position, child.size)
			if armRect.intersects(childRect):
				is_fist_overlap = true
				overlapObject = child
				return true

	is_fist_overlap = false
	return false

func move_hand():
	hand.position = lerp(hand.global_position, get_viewport().get_mouse_position(), 0.1)
	
	if is_dragging and is_fist_overlap:
		overlapObject.position = lerp(overlapObject.global_position, get_viewport().get_mouse_position(), 0.1)

func is_drop_to_trash():
	return overlapObject.get_rect().intersection(trash.get_rect()) and overlapObject.is_in_group("draggable_disable")
