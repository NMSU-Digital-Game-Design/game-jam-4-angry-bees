extends PathFollow2D

var pollen_scene:= preload("res://pollen_mini_game/pollen.tscn")
var pollen_instance
var pollen_count = PlayerVariable.pollen_inv
var difficulty = 1
var speed := 0.2
var bad_pollen: int = 0
var good_pollen: int = 0
var is_it_bad: bool
signal pollen_info
func _ready() -> void:
	if pollen_count == 0:
		pollen_count = 5
	bad_pollen = ceil(pollen_count / 5)
	good_pollen = pollen_count - bad_pollen
	print("Bad Pollen: ", bad_pollen, " Good Pollen: ", good_pollen)
	spawn_pollen()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio += speed * delta
	if progress_ratio >= 1:
		progress_ratio = 0
		if pollen_instance:
			pollen_instance.queue_free()
			pollen_instance = null
			spawn_pollen()

func spawn_pollen():
	if pollen_count == 0:
		print("Mini-game end!")
	pollen_count -= 1
	print("Pollen Count:", pollen_count)
	if pollen_count > 0:
		var r = randf()
		print(r)
		# BAD POLLEN
		
		if r > 0.50 and bad_pollen != 0:
			bad_pollen_spawn()
			bad_pollen -= 1
		elif good_pollen == 0:
			bad_pollen_spawn()
		elif good_pollen != 0:
			good_pollen_spawn()
			good_pollen -= 1


func bad_pollen_spawn():
	var instance = pollen_scene.instantiate()
	add_child(instance)
	pollen_instance = instance
	instance.modulate = Color(0, 0, 0)
	print("Bad Pollen")
	is_it_bad = true
	emit_signal("pollen_info", is_it_bad)
	
func good_pollen_spawn():
	var instance = pollen_scene.instantiate()
	add_child(instance)
	pollen_instance = instance
	print("Good Pollen")
	is_it_bad = false
	emit_signal("pollen_info", is_it_bad)


func _on_sorting_mini_game_dump_pollen() -> void:
	if pollen_instance:
		pollen_instance.queue_free()
		pollen_instance = null
		spawn_pollen()
