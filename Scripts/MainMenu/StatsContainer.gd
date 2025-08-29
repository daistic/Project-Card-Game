class_name StatsContainer

extends VBoxContainer

@onready var max_hp_score: Label = $ButtonsContainer/MaxHP/Score
@onready var max_shield_score: Label = $ButtonsContainer/MaxShield/Score
@onready var attack_score: Label = $ButtonsContainer/Attack/Score
@onready var crit_rate_score: Label = $ButtonsContainer/CritRate/Score
@onready var crit_dmg_score: Label = $ButtonsContainer/CritDmg/Score

func _ready() -> void:
	update_player_stats()

func update_player_stats() -> void:
	var player_stats = Global.get_player_stats()
	max_hp_score.text = str(player_stats.max_hp)
	max_shield_score.text = str(player_stats.max_shield)
	attack_score.text = str(player_stats.atk)
	crit_rate_score.text = "%.1f%%" % [player_stats.crit_rate]
	crit_dmg_score.text = "%.1f%%" % [(player_stats.crit_damage - 1.0) * 100]
