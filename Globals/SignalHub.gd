extends Node

signal battle_start

signal player_ready
signal enemy_ready

signal card_used(card_resource: CardInterface)
signal player_turn_finished
signal enemy_card_used(enemy_card_resource: CardInterface)
signal enemy_turn_finished

signal player_finished_calculations
signal enemy_finished_calculations

signal update_energy_labels
signal gimmick_finished_calculations
signal gimmick_message_sent(message: String)

signal battle_won
signal card_selected
signal battle_lost

func emit_battle_start() -> void:
	battle_start.emit()

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

func emit_update_energy_labels() -> void:
	update_energy_labels.emit()

func emit_gimmick_message_sent(_message: String) -> void:
	gimmick_message_sent.emit(_message)

func emit_gimmick_finished_calculations() -> void:
	gimmick_finished_calculations.emit()

func emit_battle_won() -> void:
	battle_won.emit()

func emit_card_selected() -> void:
	card_selected.emit()

func emit_battle_lost() -> void:
	battle_lost.emit()
