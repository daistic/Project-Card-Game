extends HBoxContainer

@onready var hp_bar: TextureProgressBar = $VBoxContainer/HPBar
@onready var shield_bar: TextureProgressBar = $VBoxContainer/ShieldBar

func _ready() -> void:
	SignalHub.player_ready.connect(_on_player_ready)
	SignalHub.player_finished_calculations.connect(_on_player_finished_calculations)
	
	if BattleManager.player:
		_on_player_ready()

func _on_player_ready() -> void:
	hp_bar.max_value = BattleManager.player.stats.max_hp
	shield_bar.max_value = BattleManager.player.stats.max_shield
	_on_player_finished_calculations()

func _on_player_finished_calculations() -> void:
	hp_bar.value = BattleManager.player.stats.cur_hp
	shield_bar.value = BattleManager.player.stats.cur_shield
