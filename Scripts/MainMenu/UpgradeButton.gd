class_name UpgradeButton 

extends HBoxContainer

@onready var label: Label = $VBoxContainer/Label
@onready var price_label: Label = $VBoxContainer/PriceLabel
@onready var plus: GameButton = $Plus
@onready var minus: GameButton = $Minus

enum STAT_INDEX{
	MAX_HP,
	MAX_SHIELD,
	ATK,
	CRIT_RATE,
	CRIT_DMG
}

@export var button_index: STAT_INDEX
@export var upgrade_amount: float = 10.0
@export var base_crypto: int = 0
@export var crypto_per_level: int = 0

static var cryto_used: int

var index_map: Dictionary[int, String] = {
	0: "Max HP",
	1: "Max Shield",
	2: "Attack",
	3: "Critical Rate",
	4: "Critical Damage"
}
var amount_plus_pressed: int = 0
var upgrade_level: int = -1
var crypto_needed: int = 0

signal upgrade_temp(stat: String, upgrade: float)
signal degrade_temp(stat: String, degrade: float)

func _enter_tree() -> void:
	SignalHub.upgrade_finalize.connect(_on_upgrade_finalize)

func _ready() -> void:
	get_upgrade_level()
	_update_stat_label()
	_update_price_label()
	label.text = index_map[button_index]
	cryto_used = 0

func _process(_delta: float) -> void:
	check_minus_avialability()
	check_plus_avialability()

func get_upgrade_level() -> void:
	upgrade_level = Global.get_stat_levels()[button_index]

func calculate_cryto_needed() -> int:
	return base_crypto + (upgrade_level + 1) * crypto_per_level

func check_minus_avialability() -> void:
	if amount_plus_pressed > 0:
		minus.undisable_button()
	else:
		minus.disable_button()

func check_plus_avialability() -> void:
	if Global.get_total_crypto() - (cryto_used + calculate_cryto_needed()) >= 0:
		plus.undisable_button()
	else:
		plus.disable_button()

func _update_stat_label() -> void:
	if amount_plus_pressed > 0:
		label.label_settings.font_color = Color("khaki")
		label.text = index_map[button_index] + (" (%d)" % amount_plus_pressed)
	else:
		label.label_settings.font_color = Color("black")
		label.text = index_map[button_index]

func _update_price_label() -> void:
	price_label.text = "Crypto Needed: %d" % calculate_cryto_needed()

func _on_minus_pressed() -> void:
	amount_plus_pressed -= 1
	cryto_used -= base_crypto + (upgrade_level * crypto_per_level)
	upgrade_level -= 1
	_update_stat_label()
	_update_price_label()
	degrade_temp.emit(index_map[button_index], upgrade_amount)
	SoundManager.play_sfx("Button Click")

func _on_plus_pressed() -> void:
	amount_plus_pressed += 1
	upgrade_level += 1
	cryto_used += base_crypto + (upgrade_level * crypto_per_level)
	_update_stat_label()
	_update_price_label()
	upgrade_temp.emit(index_map[button_index], upgrade_amount)
	SoundManager.play_sfx("Button Click")

func _on_upgrade_finalize() -> void:
	amount_plus_pressed = 0
	_update_stat_label()
