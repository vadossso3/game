extends Control

@onready var play_btn = $MarginContainer/VBoxContainer/Play
@onready var quit_btn = $MarginContainer/VBoxContainer/Quit

func _ready() -> void:
	play_btn.pressed.connect(_on_play)
	quit_btn.pressed.connect(_on_quit)

func _on_play():
	get_tree().call_deferred("change_scene_to_file", "res://nodes/main.tscn")

func _on_quit():
	get_tree().quit(0)
