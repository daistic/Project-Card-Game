extends Control

@onready var card_container: HBoxContainer = $MarginContainer/CardContainer
@onready var end_turn_button: TextureButton = $MarginContainer/VBoxContainer/EndTurnButton

func _enter_tree() -> void:
	SignalHub.switch_to_enemy_turn.connect(_on_changed_to_enemy_turn)

func _on_changed_to_enemy_turn() -> void:
	var cards: Array[Node] = card_container.get_children()
	
	for card in cards:
		if card is OnScreenCard:
			card.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	end_turn_button.disabled = true

func _on_end_turn_button_pressed() -> void:
	BattleManager.change_state(BattleManager.BATTLE_STATE.ENEMY_TURN)
