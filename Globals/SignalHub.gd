extends Node

signal card_used(on_screen_card: CardProperties)
signal switch_to_enemy_turn

func emit_on_card_used(_on_screen_card: CardProperties) -> void:
	card_used.emit(_on_screen_card)

func emit_switch_to_enemy_state() -> void:
	switch_to_enemy_turn.emit()
