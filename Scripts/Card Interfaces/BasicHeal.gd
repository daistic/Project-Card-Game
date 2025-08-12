class_name BasicHeal

extends CardInterface

@export var heal_amount: float = 3.0

func regenerate_stat(_damageable: Damageable) -> void:
	_damageable.cur_hp += heal_amount

func get_desc_format() -> Array:
	return [heal_amount]
