class_name CardGame

extends Control

func _enter_tree() -> void:
	SignalHub.battle_won.connect(_on_battle_won)
	SignalHub.battle_lost.connect(_on_battle_lost)

func _ready() -> void:
	BattleManager.card_game_ready(self)
	_new_enemy()

func _new_enemy() -> void:
	var enemy_scene: PackedScene
	
	if BattleManager.is_fighting_boss:
		enemy_scene = BattleManager.get_story_boss()
	else:
		enemy_scene= Global.get_random_enemy()
	
	var instance: Enemy = enemy_scene.instantiate()
	add_child(instance)

func _on_battle_won() -> void:
	BattleManager.go_to_battle_won_screen()

func _on_battle_lost() -> void:
	BattleManager.go_to_battle_lost_screen()
