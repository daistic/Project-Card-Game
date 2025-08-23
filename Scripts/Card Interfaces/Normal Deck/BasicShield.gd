class_name BasicShield

extends CardInterface

@export var shield_amount = 3.0

func regenerate_stat(_damageable: Damageable) -> void:
	_damageable.cur_shield += shield_amount
	_damageable.cur_shield = clampf(_damageable.cur_shield, 0.0, _damageable.max_shield)

func get_desc_format() -> Array:
	return [shield_amount]

func play_sfx() -> void:
	SoundManager.play_modifier_sfx("Shield")
