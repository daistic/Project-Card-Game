class_name Player

extends Control

@export var hp: float = 10.0
@export var atk: float = 1.0
@export var shield: float = 1.0
@export var max_char_energy: float = 5.0
@export var max_ai_energy: float = 5.0
@export var crit_rate: float = 25.0
@export var crit_damage: float = 1.25

var cur_energy: float = 5.0
var cur_ai_energy: float = 5.0
var damage_over_time: float = 0.0

func _init() -> void:
	SignalHub.card_used.connect(_on_card_used)

func _on_card_used(_properties: CardProperties) -> void:
	hp += _properties.heal_amount
	shield += _properties.shield
	atk += _properties.buff_attack_amount
	cur_energy -= _properties.char_energy_cost
	cur_ai_energy -= _properties.ai_energy_cost
	
	print(cur_energy)
