class_name Enemy

extends TextureRect

@export var hp: float = 10.0
@export var atk: float = 1.0
@export var shield: float = 1.0
@export var crit_rate: float = 25.0
@export var crit_damage: float = 1.25
@export var enemy_cards: Array[PackedScene] = []
@export var max_moves: int = 2

var damage_over_time: float = 0.0

func _enter_tree() -> void:
	SignalHub.card_used.connect(_on_card_used)
	SignalHub.switch_to_enemy_turn.connect(_on_changed_to_enemy_turn)

func _on_changed_to_enemy_turn() -> void:
	var moves_taken: int = 0
	
	while(moves_taken < max_moves):
		var instance: OnScreenCard = enemy_cards.pick_random().instantiate()
		SignalHub.emit_on_enemy_card_used(instance.properties)
		instance.queue_free()
		moves_taken += 1

func _on_card_used(_properties: CardProperties) -> void:
	hp -= BattleManager.calculate_damage(BattleManager.player.atk, _properties.damage, shield,
											BattleManager.player.crit_rate, 
											BattleManager.player.crit_damage)
	
	print(hp)
