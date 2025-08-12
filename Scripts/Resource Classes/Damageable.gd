class_name Damageable

extends Resource

@export var hp: float = 10.0
@export var atk: float = 1.0
@export var def: float = 1.0
@export var crit_rate: float = 15.0
@export var crit_damage: float = 1.25

var shield: float = 0.0

func card_damage(other_damageable: Damageable, damage: float) -> float:
	var total_damage = 0.0
	
	total_damage += ((other_damageable.atk * damage) - shield) / def
	clampf(total_damage, 0.0, total_damage)
	
	if randf_range(BattleManager.MINIMUM_CRIT_RATE, 
		BattleManager.MAXIMUM_CRIT_RATE) < other_damageable.crit_rate:
			total_damage *= other_damageable.crit_damage
	
	return total_damage
