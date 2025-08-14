extends Node

signal player_ready
signal enemy_ready

signal card_used(card_resource: CardInterface)
signal player_turn_finished
signal enemy_card_used(enemy_card_resource: CardInterface)
signal enemy_turn_finished

signal player_finished_calculations
signal enemy_finished_calculations

func emit_player_ready() -> void:
	player_ready.emit()

func emit_enemy_ready() -> void:
	enemy_ready.emit()

func emit_card_used(_card_resource: CardInterface) -> void:
	card_used.emit(_card_resource)

func emit_player_turn_finished() -> void:
	player_turn_finished.emit()

func emit_enemy_card_used(_enemy_card_resource: CardInterface) -> void:
	enemy_card_used.emit(_enemy_card_resource)

func emit_enemy_turn_finished() -> void:
	enemy_turn_finished.emit()

func emit_player_finished_calculations() -> void:
	player_finished_calculations.emit()

func emit_enemy_finished_calculations() -> void:
	enemy_finished_calculations.emit()
