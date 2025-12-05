extends StaticBody2D

@onready var pollen_spawn: Marker2D = $PollenSpawn

@onready var release_pollen_timer: Timer = $ReleasePollenTimer
var times_shaken: int = 0
var number_of_shakes_needed: int
var can_be_shaken: bool = true
var pollen_scene:= preload("res://pollen.tscn")
const pollen_max:= 6
var pollen_count:= 0
var pollen_amount

func _ready() -> void:
	number_of_shakes_needed = randi() % 6
	pollen_amount = randi() % pollen_max
	print(pollen_amount)
	print(number_of_shakes_needed)

func shake():
	if can_be_shaken:
		times_shaken += 1
		print("Shaken: ", times_shaken)
		if times_shaken >= number_of_shakes_needed:
			print("Shaking")
			release_pollen_timer.start()
			can_be_shaken = false
	else:
		print("Flower cannot be shaken.")

func release_pollen():
	var instance = pollen_scene.instantiate()
	add_child(instance)
	instance.global_position = pollen_spawn.global_position

func timer_time_out():
	print("Timed Out!")
	if pollen_count < pollen_amount:
		release_pollen()
		release_pollen_timer.start()
		pollen_count += 1
