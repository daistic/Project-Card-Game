class_name ShieldForCritDMG

extends StatusEffector

@export var shield_break: float = 0.135
@export var crit_dmg_debuff: float = 0.15

func apply_stat_effect(_damageable: Damageable) -> void:
	_damageable.crit_damage -= crit_dmg_debuff

func degenerate_stat(_damageable: Damageable) -> void:
	_damageable.cur_shield -= _damageable.max_shield * shield_break
	_damageable.cur_shield = clampf(_damageable.cur_shield, 0.0, _damageable.max_shield)

func get_desc_format() -> Array:
	return [shield_break * 100, crit_dmg_debuff * 100, turns]
