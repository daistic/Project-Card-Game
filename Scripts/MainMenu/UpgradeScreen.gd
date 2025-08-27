extends TextureRect

@onready var upgrades_container: VBoxContainer = $HBoxContainer/UpgradesContainer
@onready var label: Label = $Label
@onready var crypto_held_label: Label = $HBoxContainer/CryptoHeldLabel
@onready var exit_button: GameButton = $ExitButton

var temp_stats: Damageable

func _ready() -> void:
	temp_stats = Global.get_player_stats().duplicate()
	_update_cryto_held_label()

func _update_cryto_held_label() -> void:
	crypto_held_label.text = ("Crypto Held:\n%d" % 
		(Global.get_total_crypto() - UpgradeButton.cryto_used))

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

func save_player_data(_new_total_crypto: int) -> void:
	Global.save_player_data(_new_total_crypto, temp_stats)
	_update_cryto_held_label()

func save_upgrade_levels_data() -> void:
	var upgrade_levels: Array[int] = Global.get_stat_levels()
	
	for upgrade in upgrades_container.get_children():
		if upgrade is UpgradeButton:
			upgrade_levels[upgrade.button_index] = upgrade.upgrade_level
	
	Global.save_upgrade_levels_data()

func _on_exit_button_pressed() -> void:
	exit_button._reset_modulate()
	call_deferred("hide")

func _on_finalize_button_pressed() -> void:
	var total_crypto = Global.get_total_crypto() - UpgradeButton.cryto_used
	UpgradeButton.cryto_used = 0
	
	save_player_data(total_crypto)
	save_upgrade_levels_data()
	
	SignalHub.emit_upgrade_finalize()
