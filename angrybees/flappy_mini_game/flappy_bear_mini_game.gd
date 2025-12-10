extends Node2D

@onready var get_ready_time: Timer = $UI/GetReadyTimers/GetReadyTime
@onready var set_timer: Timer = $UI/GetReadyTimers/SetTimer
@onready var go_timer: Timer = $UI/GetReadyTimers/GoTimer
@onready var flappy_bear: CharacterBody2D = $LeveL/FlappyBear
@onready var starting_location: Marker2D = $LeveL/StartingLocation

@onready var ready_label: Label = $UI/Control/ReadyLabel

func _ready() -> void:
	ready_label.text = "Get ready..."
	get_tree().paused = true
func end_game_bad_end():
	print("Game Over!")


func _on_get_ready_time_timeout() -> void:
	ready_label.text = "Set..."
	set_timer.start()
func _on_set_timer_timeout() -> void:
	flappy_bear.position = starting_location.global_position
	ready_label.text = "GO!"
	get_tree().paused = false

func _on_go_timer_timeout() -> void:
	ready_label.queue_free()


func _on_honey_pt_body_entered(body: Node2D) -> void:
	#  good ending
	if body.is_in_group("player"):
		print("Got the Honey!")
