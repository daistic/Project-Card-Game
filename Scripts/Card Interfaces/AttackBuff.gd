class_name AttackBuff

extends CardInterface

@export var buff: float = 0.0
@export var turns: int = 3

func apply_stat_effect(_damageable: Damageable) -> void:
	_damageable.atk += buff

func get_desc_format() -> Array:
	return [buff, turns]
