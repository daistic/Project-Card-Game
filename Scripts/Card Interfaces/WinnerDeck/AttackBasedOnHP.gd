class_name AttackBasedOnHP

extends CardInterface

@export var damage: float = 6.9

func get_card_damage(_damageable: Damageable) -> float:
	return (((_damageable.max_hp - _damageable.cur_hp) / _damageable.max_hp) + 1.0) * damage
