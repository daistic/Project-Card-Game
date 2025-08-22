extends EnemyGimmick

func _enter_tree() -> void:
	SignalHub.battle_won.connect(_on_battle_won)

func _ready() -> void:
	BattleManager.add_malwares_to_deck()

func _on_battle_won() -> void:
	BattleManager.rid_malwares_from_deck()
