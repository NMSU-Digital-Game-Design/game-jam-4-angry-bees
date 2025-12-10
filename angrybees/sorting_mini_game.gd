extends Node2D

@onready var pollen_left_label: Label = $CanvasLayer/Control/PollenLeftLabel
@onready var cool_down_timer: Timer = $CoolDownTimer
@onready var pollen_path_follow: PathFollow2D = $Path2D/PollenPathFollow
@onready var wrong_label: Label = $CanvasLayer/Control/WrongLabel
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

var pollen_status: bool
var can_swipe := true
var times_wrong:= 0
signal dump_pollen
func _ready() -> void:
	animation_player.play("idle")
func _process(delta: float) -> void:
	update_labels()
	if can_swipe:
		# discard box
		if Input.is_action_just_released("left"):
			go_left()
			can_swipe = false
			cool_down_timer.start()
			if !pollen_status:
				fail()
			else:
				success()
		# keep box
		elif Input.is_action_just_released("right"):
			go_right()
			can_swipe = false
			cool_down_timer.start()
			if !pollen_status:
				success()
			else:
				fail()
func _on_cool_down_timer_timeout() -> void:
	can_swipe = true
	animation_player.play("idle")


func update_labels():
	if pollen_path_follow.pollen_count != null:
		pollen_left_label.text = str("Pollen Left\n", pollen_path_follow.pollen_count)
	wrong_label.text = str("Times Wrong\n", times_wrong)


func success():
	print("Correct!")
	dump_pollen.emit()
func fail():
	print("Wrong!")
	dump_pollen.emit()
	times_wrong += 1
func _on_pollen_path_follow_pollen_info(pollen_type) -> void:
	pollen_status = pollen_type
	print("Signal")

func end_mini_game():
	print("sorting mini-game ended")
	get_tree().change_scene_to_file("res://flappy_mini_game/flappy_bear_mini_game.tscn")

##### ANIMATIONS ######
func go_left():
	animation_player.play("swipe_left")
func go_right():
	animation_player.play("swipe_right")
