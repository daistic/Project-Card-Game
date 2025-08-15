class_name CardGame

extends Control

@onready var card_container: HBoxContainer = $PlayerInfoContainer/VBoxContainer/CardContainer

func _enter_tree() -> void:
	SignalHub.enemy_turn_finished.connect(_on_enemy_turn_finished)

func _ready() -> void:
	BattleManager.card_game_ready(self)

func _on_enemy_turn_finished() -> void:
	var draws: int  = 0
	
	while(draws < BattleManager.MAXIMUM_CARDS_ON_HAND):
		var card: OnScreenCard = BattleManager.draw_player_deck().instantiate()
		card_container.add_child(card)
		draws += 1

func clear_cards() -> void:
	for card in card_container.get_children():
		card.queue_free()

func _on_end_turn_button_pressed() -> void:
	clear_cards()
	SignalHub.emit_player_turn_finished()
