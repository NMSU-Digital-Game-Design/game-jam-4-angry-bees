extends CharacterBody2D

@export var speed := 150
var has_honey := false

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
