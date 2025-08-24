class_name AIShield

extends CardInterface

@export var shield: float = 0.5

func regenerate_stat(_damageable: Damageable) -> void:
	_damageable.cur_shield += shield

func get_desc_format() -> Array:
	return [shield]
