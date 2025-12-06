extends CharacterBody2D

@export var gravity := 900.0
@export var flap_strength := -300.0
@export var forward_speed := 50.0

#func _ready():
	# Start flappy bear in the vertical middle of the screen
	#position.x = 1152 / 4     # NOT center, so we can see it moving forward
	#position.y = 648 / 2      # Middle of the screen

func _physics_process(delta):
	# Apply gravity
	velocity.y += gravity * delta

	# Jump when pressed
	if Input.is_action_just_pressed("select"):
		velocity.y = flap_strength

	# Constant forward movement
	velocity.x = forward_speed

	# Move the bear
	move_and_slide()

	# Keep inside screen
	stay_in_screen()


func stay_in_screen():
	var screen_size = get_viewport_rect().size

	# Clamp X and Y so bear never escapes
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
