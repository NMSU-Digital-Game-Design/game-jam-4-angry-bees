extends Node2D

@onready var result_label  = $UI/Label
@onready var salmon_button = $UI/SalmonButton
@onready var pollen_button = $UI/PollenButton
@onready var sus_meter     = $UI/SusMeter

func _ready() -> void:
	salmon_button.pressed.connect(on_salmon_chosen)
	pollen_button.pressed.connect(on_pollen_chosen)
	sus_meter.sus_maxed.connect(_on_sus_maxed)

func on_salmon_chosen() -> void:
	sus_meter.add_sus()

	if sus_meter.is_full():
		_on_sus_maxed()
	else:
		var bar_value = sus_meter.get_node("HBoxContainer/Bar").value
		result_label.text = "We don't serve that here! \nSus level: %d / %d" % [
			int(bar_value),
			sus_meter.max_sus
		]

func on_pollen_chosen() -> void:
	result_label.text = "Sure Thing 🐝\nProceed to the cafeteria!"
	end_game()

func _on_sus_maxed() -> void:
	result_label.text = "Game Over 😢\nBees don't eat salmon!"
	end_game()

func end_game() -> void:
	salmon_button.disabled = true
	pollen_button.disabled = true
	restart_after_delay()

func restart_after_delay() -> void:
	await get_tree().create_timer(5.0).timeout

	if is_inside_tree():
		get_tree().change_scene_to_file(
			get_tree().current_scene.scene_file_path
		)
