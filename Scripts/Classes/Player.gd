class_name Player

extends Control

@export var stats: Damageable
@export var max_char_energy: float = 5.0
@export var max_ai_energy: float = 5.0

var cur_energy: float = 5.0
var cur_ai_energy: float = 5.0

func _enter_tree() -> void:
	BattleManager.player = self
	SignalHub.card_used.connect(_on_card_used)
	SignalHub.enemy_card_used.connect(_on_enemy_card_used)

func _on_card_used(_card_resource: CardInterface) -> void:
	cur_energy -= _card_resource.energy_cost
	cur_ai_energy -= _card_resource.ai_energy_cost
	
	_card_resource.regenerate_stat(stats)
	if _card_resource.is_stat_effector:
		stats.stat_effects.append(_card_resource)
	
	print(stats.cur_hp)
	print(stats.cur_shield)

func _on_enemy_card_used(_card_resource: CardInterface) -> void:
	#do something
	
	print(stats.hp)
