extends Node

signal card_used(on_screen_card: CardProperties)
signal switch_to_enemy_turn
signal enemy_card_used(enemy_card: CardProperties)

func emit_on_card_used(_on_screen_card: CardProperties) -> void:
	card_used.emit(_on_screen_card)

func emit_switch_to_enemy_state() -> void:
	switch_to_enemy_turn.emit()

func emit_on_enemy_card_used(_enemy_card: CardProperties) -> void:
	enemy_card_used.emit(_enemy_card)
