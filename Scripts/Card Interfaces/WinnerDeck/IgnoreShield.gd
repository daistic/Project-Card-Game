class_name IgnoreShield

extends StatusEffector

@export var debuff: float = 0.5

func apply_stat_effect(_damageable: Damageable) -> void:
	_damageable.cur_shield /= 2

func get_desc_format() -> Array:
	return [debuff, turns]
