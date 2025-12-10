extends Control
@onready var main_menu: Button = $MainMenu
@onready var found_label: Label = $FoundLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("select"):
		_on_youre_not_supposed_to_be_here_finished()


func _on_youre_not_supposed_to_be_here_finished() -> void:
	main_menu.show()
	found_label.show()

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
