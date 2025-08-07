class_name Enemy

extends TextureRect

@export var hp: float = 10.0
@export var atk: float = 1.0
@export var shield: float = 1.0
@export var crit_rate: float = 25.0
@export var crit_damage: float = 1.25

var damage_over_time: float = 0.0

func _enter_tree() -> void:
	SignalHub.card_used.connect(_on_card_used)

func _on_card_used(_properties: CardProperties) -> void:
	hp -= BattleManager.calculate_damage(_properties.damage, shield)
	
	print(hp)
