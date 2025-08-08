class_name Player

extends Control

@export var damageable: Damageable

@export var max_char_energy: float = 5.0
@export var max_ai_energy: float = 5.0

var cur_energy: float = 5.0
var cur_ai_energy: float = 5.0
var damage_over_time: float = 0.0

func _enter_tree() -> void:
	BattleManager.player = self
	SignalHub.card_used.connect(_on_card_used)
	SignalHub.enemy_card_used.connect(_on_enemy_card_used)

func _on_enemy_card_used(_properties: CardProperties) -> void:
	damageable.hp -= BattleManager.calculate_damage_to_self(BattleManager.enemy.damageable, 
													damageable, _properties.damage)
	
	print(damageable.hp)

func _on_card_used(_properties: CardProperties) -> void:
	damageable.hp += _properties.heal_amount
	damageable.shield += _properties.shield
	damageable.atk += _properties.buff_attack_amount
	cur_energy -= _properties.char_energy_cost
	cur_ai_energy -= _properties.ai_energy_cost
	
	print(cur_energy)
