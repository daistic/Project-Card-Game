class_name BasicHeal

extends CardInterface

@export var heal_amount: float = 0.135

func regenerate_stat(_damageable: Damageable) -> void:
	_damageable.cur_hp += _damageable.max_hp * heal_amount
	_damageable.cur_hp = clampf(_damageable.cur_hp, 0.0, _damageable.max_hp)

func get_desc_format() -> Array:
	return [heal_amount * 100]

func play_sfx() -> void:
	SoundManager.play_modifier_sfx("Heal")
