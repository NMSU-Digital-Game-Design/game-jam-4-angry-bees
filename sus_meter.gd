extends Control

@onready var bar: ProgressBar = $HBoxContainer/Bar
@onready var bee_icon: TextureRect = $HBoxContainer/BeeIcon

@export var max_sus: int = 3:
	set(value):
		max_sus = max(value, 1)
		if bar:
			bar.max_value = max_sus

signal sus_maxed

func _ready() -> void:
	bar.min_value = 0
	bar.max_value = max_sus
	bar.value = 0
	_update_look()

func add_sus(amount: int = 1) -> void:
	bar.value = clamp(bar.value + amount, bar.min_value, bar.max_value)
	_update_look()
	if bar.value >= bar.max_value:
		sus_maxed.emit()

func reset() -> void:
	bar.value = 0
	_update_look()

func is_full() -> bool:
	return bar.value >= bar.max_value

func _update_look() -> void:
	var t: float = float(bar.value) / float(max_sus)  

	var c: Color

	if t == 0.0:
		c = Color("#FFFFFF")   # normal bee
	elif t < 0.5:
		c = Color("#E1B44C")   # yellow (sus)
	elif t < 1.0:
		c = Color("#C98C2A")   # orange (very sus)
	else:
		c = Color("#B03030")   # red (MAX SUS)

	# ✅ Only color change, no tilt/scale
	bee_icon.modulate = c
