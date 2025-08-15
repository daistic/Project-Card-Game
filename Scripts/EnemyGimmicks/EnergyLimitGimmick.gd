extends EnemyGimmick

@export var energy_cap: int = 3
@export var gimmick_turns: int = 2
@export var max_next_application: int = 5
@export var min_next_application: int = 3
@export var gimmick_message: String = ""

var player_max_energy: int = 5
var apply_in : int
var cur_gimmick_turns: int = gimmick_turns
var is_active: bool = false

func _enter_tree() -> void:
	SignalHub.player_ready.connect(_on_player_ready)
	SignalHub.enemy_turn_finished.connect(_on_enemy_turn_finished)

func _ready() -> void:
	if BattleManager.player != null:
		_on_player_ready()
	
	_new_apply_in()
	SignalHub.emit_gimmick_finished_calculations()

func _on_player_ready() -> void:
	player_max_energy = BattleManager.player.max_char_energy

func _on_enemy_turn_finished() -> void:
	if is_active:
		cur_gimmick_turns -= 1
		
		if cur_gimmick_turns <= 0:
			is_active = false
			_restore_player_max_energy()
			_new_apply_in()
	else:
		apply_in -= 1
		print(apply_in)
		
		if apply_in <= 0:
			is_active = true
			cur_gimmick_turns = gimmick_turns
			_apply_gimmick()
	
	SignalHub.emit_gimmick_finished_calculations()

func _new_apply_in() -> void:
	apply_in = randi_range(min_next_application, max_next_application)

func _apply_gimmick() -> void:
	var active_player:Player = BattleManager.player
	
	if active_player == null:
		await SignalHub.player_ready
	
	active_player.max_char_energy = energy_cap
	active_player.cur_energy = energy_cap
	SignalHub.emit_update_energy_labels()

func _restore_player_max_energy() -> void:
	var active_player = BattleManager.player
	
	if active_player == null:
		await  SignalHub.player_ready
	
	active_player.max_char_energy = player_max_energy
	active_player.cur_energy = player_max_energy
	SignalHub.emit_update_energy_labels()

func get_formatted_message() -> String:
	if is_active:
		return ""
	else:
		return (gimmick_message % apply_in) + "\n"
