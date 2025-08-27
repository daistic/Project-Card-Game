class_name ShieldForAttack

extends StatusEffector

@export var shield: float = 0.175
@export var attack_debuff: float = 0.13

func regenerate_stat(_damageable: Damageable) -> void:
	_damageable.cur_shield += _damageable.max_shield * shield
	_damageable.cur_shield = clampf(_damageable.cur_shield, 0.0, _damageable.max_shield)

func apply_stat_effect(_damageable: Damageable) -> void:
	_damageable.atk -= _damageable.atk * attack_debuff

func get_desc_format() -> Array:
	return [shield * 100, attack_debuff * 100, turns]
