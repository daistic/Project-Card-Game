class_name UpgradeScreen

extends TextureRect

@onready var upgrades_container: VBoxContainer = $UpgradesContainer
@onready var upgrade_buttons_container: VBoxContainer = $UpgradesContainer/HBoxContainer/ButtonsContainer
@onready var crypto_held_label: Label = $UpgradesContainer/HBoxContainer/CryptoHeldLabel
@onready var finalize_button: GameButton = $FinalizeButton

@onready var stats_container: StatsContainer = $StatsContainer
@onready var reset_button: GameButton = $ResetButton

@onready var exit_button: GameButton = $ExitButton

var temp_stats: Damageable
var is_on_upgrade: bool = true

func _ready() -> void:
	temp_stats = Global.get_player_stats().duplicate()
	_update_cryto_held_label()

func _update_cryto_held_label() -> void:
	crypto_held_label.text = ("Crypto Held:\n%d" % 
		(Global.get_total_crypto() - UpgradeButton.cryto_used))

func save_player_data(_new_total_crypto: int) -> void:
	Global.save_player_data(_new_total_crypto, temp_stats)
	_update_cryto_held_label()

func save_upgrade_levels_data() -> void:
	var upgrade_levels: Array[int] = Global.get_stat_levels()
	
	for upgrade in upgrade_buttons_container.get_children():
		if upgrade is UpgradeButton:
			upgrade_levels[upgrade.button_index] = upgrade.upgrade_level
	
	Global.save_upgrade_levels_data()

func _on_upgrade_temp(stat: String, upgrade: float) -> void:
	match stat:
		"Attack":
			temp_stats.atk += upgrade
		"Max HP":
			temp_stats.max_hp += upgrade
		"Max Shield":
			temp_stats.max_shield += upgrade
		"Critical Rate":
			temp_stats.crit_rate += upgrade
		"Critical Damage":
			temp_stats.crit_damage += upgrade
	
	_update_cryto_held_label()

func _on_degrade_temp(stat: String, upgrade: float) -> void:
	match stat:
		"Attack":
			temp_stats.atk -= upgrade
		"Max HP":
			temp_stats.max_hp -= upgrade
		"Max Shield":
			temp_stats.max_shield -= upgrade
		"Critical Rate":
			temp_stats.crit_rate -= upgrade
		"Critical Damage":
			temp_stats.crit_damage -= upgrade
	
	_update_cryto_held_label()

func _on_exit_button_pressed() -> void:
	exit_button._reset_modulate()
	call_deferred("hide")

func _on_finalize_button_pressed() -> void:
	var total_crypto = Global.get_total_crypto() - UpgradeButton.cryto_used
	UpgradeButton.cryto_used = 0
	
	save_player_data(total_crypto)
	save_upgrade_levels_data()
	
	stats_container.update_player_stats()
	SignalHub.emit_upgrade_finalize()

func _on_switch_view_button_pressed() -> void:
	if is_on_upgrade:
		upgrades_container.hide()
		finalize_button.hide()
		stats_container.show()
		reset_button.show()
		is_on_upgrade = false
	else:
		upgrades_container.show()
		finalize_button.show()
		stats_container.hide()
		reset_button.hide()
		is_on_upgrade = true
