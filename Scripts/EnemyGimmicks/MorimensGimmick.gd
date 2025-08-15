extends EnemyGimmick

@export var malware_deck: Array[PackedScene]

func _enter_tree() -> void:
	SignalHub.enemy_ready.connect(_on_enemy_ready)

func _on_enemy_ready() -> void:
	var active_player: Player = BattleManager.player
	
	if active_player == null:
		await SignalHub.player_ready
	
	for card in malware_deck:
		BattleManager.player_deck.append(card)
		print(BattleManager.player_deck)
