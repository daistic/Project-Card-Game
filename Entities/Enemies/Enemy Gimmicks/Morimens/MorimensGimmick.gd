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
	var index: int = 0
	while(index < malware_deck.size()):
		BattleManager.player_deck.pop_back()
		index += 1

func _on_player_turn_finished() -> void:
	if has_been_added:
		return
	
	add_malwares_to_deck()
	has_been_added = true

func _on_battle_won() -> void:
	rid_malwares_from_deck()
