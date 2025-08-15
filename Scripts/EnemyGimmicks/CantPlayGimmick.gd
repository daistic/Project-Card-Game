extends Node

@export var max_next_application: int = 5
@export var min_next_application: int = 3

var apply_in : int

func _enter_tree() -> void:
	SignalHub.enemy_turn_finished.connect(_on_enemy_turn_finished)

func _ready() -> void:
	_new_apply_in()

func _new_apply_in() -> void:
	apply_in = randi_range(min_next_application, max_next_application)
	print(apply_in)

func _on_enemy_turn_finished() -> void:
	apply_in -= 1
	print(apply_in)
	
	if apply_in <= 0:
		_apply_gimmick()
		_new_apply_in()

func _apply_gimmick() -> void:
	var active_player: Player = BattleManager.player
	
	if active_player == null:
		await SignalHub.player_ready
	
	if BattleManager.game_scene != null:
		BattleManager.game_scene.clear_cards()
