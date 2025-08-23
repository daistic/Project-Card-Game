class_name AttackBasedOnAI

extends CardInterface

@export var base_damage: float = 4.5

var cur_ai_energy: int

func get_card_damage(_damageable: Damageable) -> float:
	cur_ai_energy = BattleManager.player.ai_energy.current
	return base_damage * cur_ai_energy

func get_desc_format() -> Array:
	#does nothing
	return []
