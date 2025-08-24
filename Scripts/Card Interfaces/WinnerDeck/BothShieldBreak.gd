class_name BothShieldBreak

extends CardInterface

@export var shield_break: float = 0.15
@export var shield_break_enemy: float = 0.25

func regenerate_stat(_damageable: Damageable) -> void:
	_damageable.cur_shield -= shield_break
	_damageable.cur_shield = clampf(_damageable.cur_shield, 0.0, _damageable.max_shield)

func degenerate_stat(_damageable: Damageable) -> void:
	_damageable.cur_shield -= shield_break_enemy
	_damageable.cur_shield = clampf(_damageable.cur_shield, 0.0, _damageable.max_shield)

func get_desc_format() -> Array:
	return [shield_break, shield_break_enemy]
