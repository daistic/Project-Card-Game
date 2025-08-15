class_name Player

extends Control

@export var stats: Damageable
@export var max_char_energy: int = 5
@export var max_ai_energy: int = 5

var cur_energy: int = 5
var cur_ai_energy: int = 5

func _enter_tree() -> void:
	SignalHub.card_used.connect(_on_card_used)
	SignalHub.enemy_card_used.connect(_on_enemy_card_used)
	SignalHub.player_turn_finished.connect(_on_player_turn_finished)
	SignalHub.enemy_turn_finished.connect(_on_enemy_turn_finished)

func _ready() -> void:
	BattleManager.new_player(self)
	SignalHub.emit_player_ready()

func _on_card_used(_card_resource: CardInterface) -> void:
	cur_energy -= _card_resource.energy_cost
	cur_ai_energy -= _card_resource.ai_energy_cost
	
	_card_resource.regenerate_stat(stats)
	if _card_resource is StatusEffector:
		if _card_resource.is_debuff:
			BattleManager.enemy.new_status_effect(_card_resource)
		else:
			stats.status_effects.append(_card_resource)
	
	SignalHub.emit_player_finished_calculations()
	#print(BattleManager.enemy.stats.stat_effects)
	#print(stats.cur_hp)

func _on_enemy_card_used(_card_resource: CardInterface) -> void:
	var enemy_stats: Damageable = BattleManager.enemy.stats.get_stats_after_status()
	
	stats.cur_hp -= stats.card_damage(enemy_stats, 
		_card_resource.get_card_damage(enemy_stats))
	
	SignalHub.emit_player_finished_calculations()
	#print(stats.cur_hp)

func _on_player_turn_finished() -> void:
	for effect in stats.status_effects:
		if effect is StatusEffector:
			effect.turns -= 1
		
		if effect.turns <= 0:
			effect.on_erased()
			stats.status_effects.erase(effect)
		else:
			effect.apply_effect()
	
	cur_energy = max_char_energy
	SignalHub.emit_update_energy_labels()
	#print(stats.status_effects)

func _on_enemy_turn_finished() -> void:
	pass

func new_status_effect(_card_resource: StatusEffector) -> void:
	if _card_resource.can_be_applied(stats):
		stats.status_effects.append(_card_resource.duplicate())
		_card_resource.on_appended()
