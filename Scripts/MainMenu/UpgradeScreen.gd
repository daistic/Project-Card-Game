extends TextureRect

@onready var upgrades_container: VBoxContainer = $HBoxContainer/UpgradesContainer
@onready var label: Label = $Label
@onready var crypto_held_label: Label = $HBoxContainer/CryptoHeldLabel

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

func _on_exit_button_pressed() -> void:
	hide()

func _on_finalize_button_pressed() -> void:
	var total_crypto = Global.get_total_crypto() - UpgradeButton.cryto_used
	UpgradeButton.cryto_used = 0
	Global.save_data(total_crypto, temp_stats)
	_update_cryto_held_label()
	SignalHub.emit_upgrade_finalize()
