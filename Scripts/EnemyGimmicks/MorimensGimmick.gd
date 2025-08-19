extends EnemyGimmick

@export var malware_deck: Array[PackedScene]

func _enter_tree() -> void:
	SignalHub.battle_won.connect(_on_battle_won)

func _ready() -> void:
	_add_malwares()

func _add_malwares() -> void:
	var active_player: Player = BattleManager.player
	
	if active_player == null:
		await SignalHub.player_ready
	
	for card in malware_deck:
		BattleManager.player_deck.append(card)
		print(BattleManager.player_deck)

func _on_battle_won() -> void:
	for card_scene in BattleManager.player_deck:
		var scene: OnScreenCard = card_scene.instantiate()
		if scene.card_resource.is_malware:
			BattleManager.player_deck.erase(card_scene)
		scene.queue_free()
