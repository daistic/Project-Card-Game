class_name CardGame

extends Control

@onready var card_container: HBoxContainer = $PlayerInfoContainer/VBoxContainer/CardContainer

func _enter_tree() -> void:
	SignalHub.enemy_turn_finished.connect(_on_enemy_turn_finished)
	SignalHub.battle_won.connect(_on_battle_won)
	SignalHub.battle_lost.connect(_on_battle_lost)

func _ready() -> void:
	BattleManager.card_game_ready(self)
	_new_enemy()
	_draw_cards()

func _new_enemy() -> void:
	var enemy_scene: PackedScene
	
	if BattleManager.is_fighting_boss:
		enemy_scene = BattleManager.get_story_boss()
	else:
		enemy_scene= Global.get_random_enemy()
	
	var instance: Enemy = enemy_scene.instantiate()
	add_child(instance)

func clear_cards() -> void:
	for card in card_container.get_children():
		card.queue_free()

func _on_enemy_turn_finished() -> void:
	_draw_cards()

func _draw_cards() -> void:
	var draws: int  = 0
	
	while(draws < BattleManager.MAXIMUM_CARDS_ON_HAND):
		var card: OnScreenCard = BattleManager.draw_player_deck().instantiate()
		card_container.add_child(card)
		draws += 1

func _on_battle_won() -> void:
	BattleManager.go_to_battle_won_screen()

func _on_battle_lost() -> void:
	BattleManager.go_to_battle_lost_screen()

func _on_end_turn_button_pressed() -> void:
	clear_cards()
	SignalHub.emit_player_turn_finished()
