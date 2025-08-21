class_name CritDmgBuff

extends StatusEffector

@export var buff: float

func apply_stat_effect(_damageable: Damageable) -> void:
	_damageable.crit_damage += buff

func get_desc_format() -> Array:
	return [buff]
