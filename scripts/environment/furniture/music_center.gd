extends StaticBody2D

@onready var animated_sprite = $AnimatedSprite2D

signal music_interacted(audio_player, is_playing)

@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var interact_area = $Area2D

var paused_position = 0.0
var is_playing : bool = false
var is_player_entered

func _ready() -> void:
	interact_area.body_entered.connect(_on_body_entered)
	interact_area.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		is_player_entered = true
		body.emit_signal("can_interact", true)

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		is_player_entered = false
		body.emit_signal("can_interact", false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action") and is_player_entered:
		_interact()

func _interact():
	if is_playing:
		paused_position = audio_player.get_playback_position()
		audio_player.stop()
		animated_sprite.play("stop")
		is_playing = false
	else:
		audio_player.play(paused_position)
		animated_sprite.play("playing")
		is_playing = true
