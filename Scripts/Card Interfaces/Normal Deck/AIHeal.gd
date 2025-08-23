class_name AIHeal

extends CardInterface

@export var heal_amount: float = 0.0
@export var shield_amount: float = 0.0

func regenerate_stat(_damageable: Damageable) -> void:
	_damageable.cur_hp += heal_amount
	_damageable.cur_shield += shield_amount
	_damageable.cur_hp = clampf(_damageable.cur_hp, 0.0, _damageable.max_hp)
	_damageable.cur_shield = clampf(_damageable.cur_shield, 0.0, _damageable.max_shield)

func get_desc_format() -> Array:
	return [heal_amount, shield_amount]

func play_sfx() -> void:
	SoundManager.play_modifier_sfx("Heal")
