extends Control

@onready var card_container: HBoxContainer = $MarginContainer/CardContainer
@onready var end_turn_button: TextureButton = $MarginContainer/VBoxContainer/EndTurnButton

func _enter_tree() -> void:
	SignalHub.player_turn_finished.connect(_on_player_turn_finished)
	SignalHub.enemy_turn_finished.connect(_on_enemy_turn_finished)

func _on_player_turn_finished() -> void:
	var cards: Array[Node] = card_container.get_children()
	
	for card in cards:
		if card is OnScreenCard:
			card.queue_free()
	
	end_turn_button.disabled = true

func _on_enemy_turn_finished() -> void:
	var cur_cards_amount = 0
	
	while(cur_cards_amount < BattleManager.MAXIMUM_CARDS_ON_HAND):
		var card: OnScreenCard = BattleManager.draw_from_player_deck().instantiate()
		card_container.add_child(card)
		cur_cards_amount += 1
	
	end_turn_button.disabled = false

func _on_end_turn_button_pressed() -> void:
	BattleManager.change_state(BattleManager.BATTLE_STATE.ENEMY_TURN)
