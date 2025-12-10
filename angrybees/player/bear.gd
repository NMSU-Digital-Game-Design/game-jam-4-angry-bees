extends CharacterBody2D

@export var speed := 300
var has_honey := false
var pollen_inv = PlayerVariable.pollen_inv

func _ready() -> void:
	$needPollen.hide()
	$taskComplete.hide()
	$taskSort.hide()
	
func _physics_process(_delta):
	var dir := Vector2.ZERO

	#GENERAL FOR TESTING NEEDS CHANGE FOR JUMPING AND REMOVE FLYING
	# Arrow-key movement (uses built-in UI actions)
	if Input.is_action_pressed("right"):
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = false
		dir.x += 1
	if Input.is_action_pressed("left"):
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = true
		dir.x -= 1
	if Input.is_action_pressed("down"):
		dir.y += 1
	if Input.is_action_pressed("up"):
		$AnimatedSprite2D.play("fly")
		dir.y -= 1
	if Input.is_action_just_released("right") || Input.is_action_just_released("left"):
		$AnimatedSprite2D.play("idle")

	velocity = dir.normalized() * speed
	move_and_slide()

func steal_honey():
	has_honey = true
	print("Honey stolen!")

func _on_hive_honey_stolen(bear):
	bear.steal_honey()

var pollen = 0
func _on_bee_pollen_body_entered(body: Node2D) -> void:
	if pollen == 0:
		get_tree().change_scene_to_file("res://picking_up_pollen.tscn")
		pollen = 1
	else:
		$taskSort.show()
		$Timer.start()

var fly = 0
func _on_bee_fly_body_entered(body: Node2D) -> void:
	if fly == 0:
		get_tree().change_scene_to_file("res://flappy_mini_game/flappy_bear_mini_game.tscn")
		fly = 1
	else:
		$taskComplete.show()
		$Timer.start()

var sort = 0
func _on_bee_sort_body_entered(body: Node2D) -> void:
	if sort == 0:
		if pollen == 1:
			get_tree().change_scene_to_file("res://sorting_mini_game.tscn")
			sort = 1
		
		if pollen != 1:
			$needPollen.show()
			$Timer.start()
	else:
		$taskComplete.show()
		$Timer.show()
		


func _on_timer_timeout() -> void:
	$needPollen.hide()
	$taskComplete.hide()
	$taskSort.hide()
