class_name AIShield

extends CardInterface

@export var shield: float = 0.175

func regenerate_stat(_damageable: Damageable) -> void:
	_damageable.cur_shield += _damageable.max_shield * shield
	_damageable.cur_shield = clampf(_damageable.cur_shield, 0.0, _damageable.max_shield)

func get_desc_format() -> Array:
	return [shield * 100]
