class_name Damageable

extends Resource

@export var max_hp: float
@export var max_shield: float
@export var atk: float
@export var crit_rate: float
@export var crit_damage: float

var cur_hp: float = max_hp
var cur_shield: float = 0.0
var status_effects: Array[CardInterface] = []

func card_damage(other_damageable: Damageable, damage: float, 
		display_spawnpoint: Node, enemy_damaged: bool) -> float:
	
	var total_damage: float = 0.0
	var is_crit: bool = false
	
	total_damage += ((other_damageable.atk * damage) / 
		(get_stats_after_status().cur_shield + 1.0))
	total_damage = clampf(total_damage, 0.0, total_damage)
	
	if randf_range(BattleManager.MINIMUM_CRIT_RATE, 
		BattleManager.MAXIMUM_CRIT_RATE) < other_damageable.crit_rate:
			total_damage *= other_damageable.crit_damage
			is_crit = true
	
	EffectHub.display_damage(total_damage, display_spawnpoint, enemy_damaged, is_crit)
	EffectHub.handle_attack_sfx(total_damage, is_crit, enemy_damaged)
	return total_damage

func get_stats_after_status() -> Damageable:
	var sas: Damageable = Damageable.new()
	
	sas.max_hp = max_hp
	sas.cur_hp = cur_hp
	sas.max_shield = max_shield
	sas.cur_shield = cur_shield
	sas.atk = atk
	sas.crit_rate = crit_rate
	sas.crit_damage = crit_damage
	
	for status in status_effects:
		status.apply_stat_effect(sas)
	
	return sas

func reset_stats() -> void:
	cur_hp = max_hp
	cur_shield = 0.0
	status_effects.clear()
	print(cur_hp, cur_shield)
