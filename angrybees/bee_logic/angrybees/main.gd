extends Node2D

@onready var result_label = $UI/Label
@onready var salmon_button = $UI/SalmonButton
@onready var pollen_button = $UI/PollenButton

func _ready():
	salmon_button.pressed.connect(on_salmon_chosen)
	pollen_button.pressed.connect(on_pollen_chosen)

func on_salmon_chosen():
	result_label.text = "Game Over 😢\nWe don't serve that here!"
	end_game()

func on_pollen_chosen():
	result_label.text = "Sure Thing 🐝\nProceed to the cafeteria!"
	end_game()

func end_game():
	salmon_button.disabled = true
	pollen_button.disabled = true
	restart_after_delay()

func restart_after_delay():
	await get_tree().create_timer(5.0).timeout
	get_tree().reload_current_scene()
