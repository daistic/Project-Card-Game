class_name AttackBuff

extends StatusEffector

@export var buff: float = 0.0

func apply_stat_effect(_damageable: Damageable) -> void:
	_damageable.atk += buff

func get_desc_format() -> Array:
	return [buff, turns]
