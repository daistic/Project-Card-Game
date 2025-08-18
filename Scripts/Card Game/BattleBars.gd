class_name BattleBars

extends HBoxContainer

@onready var circle: TextureRect = $Circle
@onready var hp_bar: TextureProgressBar = $VBoxContainer/HPBar
@onready var shield_bar: TextureProgressBar = $VBoxContainer/ShieldBar

@export var is_enemy: bool = false

func bars_setup(max_hp: float, max_shield: float) -> void:
	hp_bar.max_value = max_hp
	shield_bar.max_value = max_shield

func update_bars(cur_hp: float, cur_shield: float) -> void:
	hp_bar.value = cur_hp
	shield_bar.value = cur_shield
