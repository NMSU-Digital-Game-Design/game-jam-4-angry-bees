extends Node2D


@onready var pollen_label: Label = $UI/Control/PollenLabel
@onready var time_left_label: Label = $UI/Control/TimeLeftLabel
@onready var time_left: Timer = $TimeLeft

@export var wait_time:= 30.0

func _process(delta: float) -> void:
	pollen_label.text = str("Pollen: " , PlayerVariable.pollen_inv)
	time_left_label.text = str("Time Remaining: ", wait_time)

func end_mini_game():
	pass

func _on_time_left_timeout() -> void:
	if wait_time == 0:
		end_mini_game()
		print("Mini-Game Ended!")
	else:
		wait_time -= 1
		time_left.start()
