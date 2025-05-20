extends CenterContainer

var shake_strength := 0.0
var shake_timer := 0.0
var original_position := Vector2.ZERO

func _ready():
	original_position = position

func _process(delta):
	if shake_timer > 0:
		shake_timer -= delta
		var offset = Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
		position = original_position + offset
	else:
		position = original_position

func shake(strength: float, duration: float):
	shake_strength = strength
	shake_timer = duration
