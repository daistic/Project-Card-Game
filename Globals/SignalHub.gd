extends Node

signal card_used(on_screen_card: CardProperties)
signal player_turn_finished
signal enemy_card_used(enemy_card: CardProperties)
signal enemy_turn_finished

func emit_card_used(_on_screen_card: CardProperties) -> void:
	card_used.emit(_on_screen_card)

func emit_player_turn_finished() -> void:
	player_turn_finished.emit()

func emit_enemy_card_used(_enemy_card: CardProperties) -> void:
	enemy_card_used.emit(_enemy_card)

func emit_enemy_turn_finished() -> void:
	enemy_turn_finished.emit()
