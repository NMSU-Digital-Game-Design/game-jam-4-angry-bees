extends CharacterBody2D

@export var speed := 150
var has_honey := false

func _physics_process(delta):
	var dir := Vector2.ZERO

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
		dir.y -= 1

	velocity = dir.normalized() * speed
	move_and_slide()

func steal_honey():
	has_honey = true
	print("Honey stolen!")

func _on_hive_honey_stolen(bear):
	bear.steal_honey()
