class_name Enemy

extends TextureRect

@export var stats: Damageable
@export var enemy_cards: Array[CardInterface] = []
@export var max_moves: int = 2

func _enter_tree() -> void:
	SignalHub.card_used.connect(_on_card_used)
	SignalHub.enemy_card_used.connect(_on_enemy_card_used)
	SignalHub.player_turn_finished.connect(_on_player_turn_finished)

func _ready() -> void:
	BattleManager.new_enemy(self)

func _on_card_used(_card_resource: CardInterface) -> void:
	var player_stats: Damageable = BattleManager.player.stats.get_stats_after_status()
	
	stats.cur_hp -= stats.card_damage(player_stats, 
		_card_resource.get_card_damage(player_stats))
	
	#print(stats.cur_hp)

func _on_enemy_card_used(_card_resource: CardInterface) -> void:
	_card_resource.regenerate_stat(stats)
	if _card_resource is StatEffector:
		if _card_resource.is_debuff:
			BattleManager.player.stats.stat_effects.append(_card_resource)
		else:
			stats.stat_effects.append(_card_resource)

func _on_player_turn_finished() -> void:
	var move_number: int = 0
	
	while(move_number < max_moves):
		SignalHub.emit_enemy_card_used(enemy_cards.get(move_number))
		move_number += 1
	
	SignalHub.emit_enemy_turn_finished()

func _on_enemy_turn_finished() -> void:
	_shuffle_cards()

func _shuffle_cards() -> void:
	enemy_cards.shuffle()
