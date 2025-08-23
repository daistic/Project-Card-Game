class_name RandomAttack

extends CardInterface

@export var max_damage: float = 5.5
@export var min_damage: float = 1.0

func get_card_damage(_damageable: Damageable) -> float:
	return randf_range(min_damage, max_damage)

func get_desc_format() -> Array:
	return [min_damage, max_damage]
