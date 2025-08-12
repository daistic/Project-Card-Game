class_name BasicShield

extends CardInterface

@export var shield_amount = 3.0

func regenerate_stat(_damageable: Damageable) -> void:
	_damageable.cur_shield += shield_amount

func get_desc_format() -> Array:
	return [shield_amount]
