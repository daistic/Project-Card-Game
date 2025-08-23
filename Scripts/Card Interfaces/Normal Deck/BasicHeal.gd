class_name BasicHeal

extends CardInterface

@export var heal_amount: float = 3.0

func regenerate_stat(_damageable: Damageable) -> void:
	_damageable.cur_hp += heal_amount
	_damageable.cur_hp = clampf(_damageable.cur_hp, 0.0, _damageable.max_hp)

func get_desc_format() -> Array:
	return [heal_amount]

func play_sfx() -> void:
	SoundManager.play_modifier_sfx("Heal")
