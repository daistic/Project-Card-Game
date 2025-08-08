class_name Enemy

extends TextureRect

@export var damageable: Damageable
@export var enemy_cards: Array[PackedScene] = []
@export var max_moves: int = 2

var damage_over_time: float = 0.0

func _enter_tree() -> void:
	BattleManager.enemy = self
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
	damageable.hp -= BattleManager.calculate_damage_to_self(BattleManager.player.damageable, 
													damageable, _properties.damage)
	print(damageable.hp)
