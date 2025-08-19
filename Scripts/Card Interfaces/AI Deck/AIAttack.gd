class_name AIAttack

extends CardInterface

@export var damage: float = 0.0
@export var shield_break: float = 0.0

func get_card_damage(_damageable: Damageable) -> float:
	return damage

func degenerate_stat(_damageable: Damageable) -> void:
	_damageable.cur_shield -= shield_break

func get_desc_format() -> Array:
	return [damage, shield_break]
