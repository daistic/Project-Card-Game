extends EnemyGimmick

@export var malware_deck: Array[PackedScene]

func _ready() -> void:
	_add_malwares()

func _add_malwares() -> void:
	var active_player: Player = BattleManager.player
	
	if active_player == null:
		await SignalHub.player_ready
	
	for card in malware_deck:
		BattleManager.player_deck.append(card)
		print(BattleManager.player_deck)
