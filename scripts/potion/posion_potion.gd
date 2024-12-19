extends Area2D

@export var damage_per_second: int = 20
@export var duration: float = 3.0

var timer: Timer
var elapsed_time: float = 0.0

signal posionPlayer(damage)

func _ready() -> void:
	timer = $DamageTimer
	body_entered.connect(_on_area_entered)
	
func start_poison():
	hide()
	timer.start()
	elapsed_time = 0.0

func _on_area_entered(body) -> void:
	if body is CharacterBody2D:
		start_poison()

func _on_damage_timer_timeout() -> void:
	emit_signal("posionPlayer", damage_per_second)
	elapsed_time += 1.0
	
	if elapsed_time >= duration:
		timer.stop()
		queue_free()
