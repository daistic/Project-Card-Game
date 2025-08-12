class_name BasicAttack

extends CardInterface

@export var damage: float

func get_card_damage() -> float:
	return damage

func get_desc_format() -> Array:
	return [damage]
