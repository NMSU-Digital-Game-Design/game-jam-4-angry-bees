extends Area2D

signal honey_stolen

func _on_body_entered(body):
	if body.name == "Bear":
		emit_signal("honey_stolen", body)
