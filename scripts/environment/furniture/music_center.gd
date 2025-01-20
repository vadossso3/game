extends StaticBody2D

@onready var animated_sprite = $AnimatedSprite2D

signal music_interacted(audio_player, is_playing)

@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D

var paused_position = 0.0
var is_playing : bool = false

func interact():
	if is_playing:
		paused_position = audio_player.get_playback_position()
		audio_player.stop()
		animated_sprite.play("stop")
		is_playing = false
	else:
		audio_player.play(paused_position)
		animated_sprite.play("playing")
		is_playing = true
