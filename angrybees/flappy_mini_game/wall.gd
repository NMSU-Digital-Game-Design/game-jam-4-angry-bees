extends Node2D

signal mini_game_over

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("mini_game_over",Callable(get_parent(), "end_game"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_collision_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Hit!")
		mini_game_over.emit()
