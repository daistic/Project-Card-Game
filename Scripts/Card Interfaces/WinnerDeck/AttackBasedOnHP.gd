class_name AttackBasedOnHP

extends CardInterface

@export var buffer: float = 10.0

func get_card_damage(_damageable: Damageable) -> float:
	return (_damageable.max_hp - buffer) / _damageable.cur_hp
