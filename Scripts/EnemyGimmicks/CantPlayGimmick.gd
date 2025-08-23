extends EnemyGimmick

@onready var sfx_player: AudioStreamPlayer = $SFXPlayer

@export var max_next_application: int = 5
@export var min_next_application: int = 3
@export var gimmick_message: String = ""

var is_active: bool = false
var apply_in : int

func _enter_tree() -> void:
	SignalHub.enemy_turn_finished.connect(_on_enemy_turn_finished)

func _ready() -> void:
	_new_apply_in()
	SignalHub.emit_gimmick_finished_calculations()

func _new_apply_in() -> void:
	apply_in = randi_range(min_next_application, max_next_application)

func _on_enemy_turn_finished() -> void:
	if is_active:
		is_active = false
		_new_apply_in()
	else:
		apply_in -= 1
		
		if apply_in <= 0:
			_apply_gimmick()
			is_active = true
	
	SignalHub.emit_gimmick_finished_calculations()

func _apply_gimmick() -> void:
	var active_player: Player = BattleManager.player
	
	if active_player == null:
		await SignalHub.player_ready
	
	active_player.clear_cards()
	sfx_player.play()

func get_formatted_message() -> String:
	if is_active:
		return ""
	else:
		return (gimmick_message % apply_in) + "\n"
