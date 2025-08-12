class_name Enemy

extends TextureRect

@export var stats: Damageable
@export var enemy_cards: Array[CardInterface] = []
@export var max_moves: int = 2

func _enter_tree() -> void:
	BattleManager.enemy = self
	SignalHub.card_used.connect(_on_card_used)
	SignalHub.player_turn_finished.connect(_on_player_turn_finished)

func _on_player_turn_finished() -> void:
	var moves_taken: int = 0
	
	while(moves_taken < max_moves):
		SignalHub.emit_enemy_card_used(enemy_cards.pick_random())
		moves_taken += 1
	
	BattleManager.change_state(BattleManager.BATTLE_STATE.PLAYER_TURN)

func _on_card_used(_card_resource: CardInterface) -> void:
	var player_stats: Damageable = BattleManager.player.stats.get_stats_after_status()
	
	stats.cur_hp -= stats.card_damage(player_stats, 
		_card_resource.get_card_damage(player_stats))
	
	#print(stats.cur_hp)
