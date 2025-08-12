extends Node

signal card_used(card_resource: CardInterface)
signal player_turn_finished
signal enemy_card_used(enemy_card_resource: CardInterface)
signal enemy_turn_finished

func emit_card_used(_card_resource: CardInterface) -> void:
	card_used.emit(_card_resource)

func emit_player_turn_finished() -> void:
	player_turn_finished.emit()

func emit_enemy_card_used(_enemy_card_resource: CardInterface) -> void:
	enemy_card_used.emit(_enemy_card_resource)

func emit_enemy_turn_finished() -> void:
	enemy_turn_finished.emit()
