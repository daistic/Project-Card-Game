class_name AttackDebuff

extends StatEffector

@export var debuff: float = 2.5

func apply_stat_effect(_damageable: Damageable) -> void:
	_damageable.atk -= debuff

func get_desc_format() -> Array:
	return[debuff, turns]
