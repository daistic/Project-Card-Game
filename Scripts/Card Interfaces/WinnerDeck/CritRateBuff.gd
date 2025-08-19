class_name CritRateBuff

extends StatusEffector

@export var buff: float

func apply_stat_effect(_damageable: Damageable) -> void:
	_damageable.crit_rate += buff

func get_desc_format() -> Array:
	return [buff, turns]
