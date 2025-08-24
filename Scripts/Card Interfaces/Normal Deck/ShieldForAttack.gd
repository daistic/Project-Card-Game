class_name ShieldForAttack

extends StatusEffector

@export var shield: float = 0.25
@export var attack_debuff: float = 13

func regenerate_stat(_damageable: Damageable) -> void:
	_damageable .cur_shield += shield
	_damageable.cur_shield = clampf(_damageable.cur_shield, 0.0, _damageable.max_shield)

func apply_stat_effect(_damageable: Damageable) -> void:
	_damageable.atk -= (_damageable.atk * attack_debuff) / 100.0

func get_desc_format() -> Array:
	return [shield, attack_debuff, turns]
