class_name AIAttack

extends CardInterface

@export var damage: float = 5.5
@export var shield_break: float = 0.02

func get_card_damage(_damageable: Damageable) -> float:
	return damage

func degenerate_stat(_damageable: Damageable) -> void:
	_damageable.cur_shield -= _damageable.max_shield * shield_break
	_damageable.cur_shield = clampf(_damageable.cur_shield, 0.0, _damageable.max_shield)

func get_desc_format() -> Array:
	return [damage, shield_break * 100]

func play_sfx() -> void:
	SoundManager.play_modifier_sfx("Shield Break")
