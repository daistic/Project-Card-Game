class_name ShieldDown

extends CardInterface

@export var down_amount = 3.0

func degenerate_stat(_damageable: Damageable) -> void:
	_damageable.cur_shield -= down_amount
	_damageable.cur_shield = clampf(_damageable.cur_shield, 0.0, _damageable.max_shield)

func get_desc_format() -> Array:
	return [down_amount]
