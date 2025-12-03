extends StaticBody2D

var times_shaken: int = 0
var number_of_shakes_needed: int
var can_be_shaken: bool = true
var pollen_scene:= preload("res://pollen.tscn")
func _ready() -> void:
	number_of_shakes_needed = randi() % 6
	print(number_of_shakes_needed)
func shake():
	if can_be_shaken:
		times_shaken += 1
		print("Shaken: ", times_shaken)
		if times_shaken >= number_of_shakes_needed:
			release_pollen()
			can_be_shaken = false
	else:
		print("Flower cannot be shaken.")
		
func release_pollen():
	print("Release!")
	pass
