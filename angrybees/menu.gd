extends Node2D

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://sceneTest.tscn")


func _on_how_to_play_pressed() -> void:
	get_tree().change_scene_to_file("res://how_to_play.tscn")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://credits.tscn")
