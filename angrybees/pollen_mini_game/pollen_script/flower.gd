extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var pollen_spawn: Marker2D = $PollenSpawn
@onready var release_pollen_timer: Timer = $ReleasePollenTimer

@export var flower_frame = 1
var times_shaken: int = 0
var number_of_shakes_needed: int
var can_be_shaken: bool = true
var pollen_scene:= preload("res://pollen_mini_game/pollen.tscn")
const pollen_max:= 6
var pollen_count:= 0
var pollen_amount
var player_deteched := false

func _ready() -> void:
	number_of_shakes_needed = randi() % 6
	pollen_amount = randi() % pollen_max
	print(pollen_amount)
	print(number_of_shakes_needed)
	sprite_2d.frame_coords = Vector2(0, flower_frame)
func _process(delta: float) -> void:
	if Input.is_action_just_released("select") and player_deteched:
		shake()
	
			
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


func _on_detect_player_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_deteched = true
		sprite_2d.frame_coords = Vector2(1, flower_frame)

func _on_detect_player_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_deteched = false
		sprite_2d.frame_coords = Vector2(0, flower_frame)
