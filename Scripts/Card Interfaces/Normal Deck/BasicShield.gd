class_name BasicShield

extends CardInterface

@export var shield_amount = 0.13

func regenerate_stat(_damageable: Damageable) -> void:
	_damageable.cur_shield += _damageable.max_shield * shield_amount
	_damageable.cur_shield = clampf(_damageable.cur_shield, 0.0, _damageable.max_shield)

func get_desc_format() -> Array:
	return [shield_amount * 100]

func play_sfx() -> void:
	SoundManager.play_modifier_sfx("Shield")
