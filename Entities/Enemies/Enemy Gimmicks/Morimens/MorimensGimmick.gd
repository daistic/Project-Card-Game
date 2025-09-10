extends EnemyGimmick

var malware_deck: Array[PackedScene]
var has_been_added: bool = false

func _enter_tree() -> void:
	SignalHub.player_turn_finished.connect(_on_player_turn_finished)
	SignalHub.battle_won.connect(_on_battle_won)

func _ready() -> void:
	malware_deck = Global.get_malware_deck()

func add_malwares_to_deck() -> void:
	var active_player: Player = BattleManager.player
	if active_player == null:
		await SignalHub.player_ready
	
	for card in malware_deck:
		BattleManager.add_to_player_deck(card)

func rid_malwares_from_deck() -> void:
	BattleManager.player_deck = BattleManager.player_deck.filter(
		func(packed_scene: PackedScene) -> bool:
			var state: SceneState = packed_scene.get_state()
			var groups: PackedStringArray = state.get_node_groups(0)
			return not groups.has("Malwares")
	)

func _on_player_turn_finished() -> void:
	if has_been_added:
		return
	
	add_malwares_to_deck()
	has_been_added = true

func _on_battle_won() -> void:
	BattleManager.reset_player_deck()
	rid_malwares_from_deck()
