extends HBoxContainer

@onready var hp_bar: TextureProgressBar = $VBoxContainer/HPBar
@onready var shield_bar: TextureProgressBar = $VBoxContainer/ShieldBar
@onready var circle: TextureRect = $Circle

const ROTATE_TIME: float = 3.0

func _ready() -> void:
	SignalHub.enemy_ready.connect(_on_enemy_ready)
	SignalHub.enemy_finished_calculations.connect(_on_enemy_finished_calculations)
	
	if BattleManager.enemy != null:
		_on_enemy_ready()

func _on_enemy_ready() -> void:
	hp_bar.max_value = BattleManager.enemy.stats.max_hp
	shield_bar.max_value = BattleManager.enemy.stats.max_shield
	_on_enemy_finished_calculations()

func _on_enemy_finished_calculations() -> void:
	hp_bar.value = BattleManager.enemy.stats.cur_hp
	shield_bar.value = BattleManager.enemy.stats.cur_shield
