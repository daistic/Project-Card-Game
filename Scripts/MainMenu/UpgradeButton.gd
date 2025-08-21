class_name UpgradeButton 

extends HBoxContainer

@onready var label: Label = $VBoxContainer/Label
@onready var price_label: Label = $VBoxContainer/PriceLabel
@onready var plus: GameButton = $Plus
@onready var minus: GameButton = $Minus

enum STAT_INDEX{
	ATK,
	MAX_HP,
	MAX_SHIELD,
	CRIT_RATE,
	CRIT_DMG
}

@export var button_index: STAT_INDEX
@export var upgrade_amount: float = 10.0
@export var crypto_needed: int = 0

static var cryto_used: int

var index_map: Dictionary[int, String] = {
	0: "Attack",
	1: "Max HP",
	2: "Max Shield",
	3: "Critical Rate",
	4: "Critical Damage"
}
var amount_plus_pressed: int = 0

signal upgrade_temp(stat: String, upgrade: float)
signal degrade_temp(stat: String, degrade: float)

func _enter_tree() -> void:
	SignalHub.upgrade_finalize.connect(_on_upgrade_finalize)

func _ready() -> void:
	label.text = index_map[button_index]
	price_label.text = "Crypto Needed: %d" % crypto_needed

func _process(_delta: float) -> void:
	check_minus_avialability()
	check_plus_avialability()

func check_minus_avialability() -> void:
	if amount_plus_pressed > 0:
		minus.undisable_button()
	else:
		minus.disable_button()

func check_plus_avialability() -> void:
	if Global.get_total_crypto() - (cryto_used + crypto_needed) >= 0:
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

func _on_minus_pressed() -> void:
	amount_plus_pressed -= 1
	cryto_used -= crypto_needed
	_update_stat_label()
	degrade_temp.emit(index_map[button_index], upgrade_amount)

func _on_plus_pressed() -> void:
	amount_plus_pressed += 1
	cryto_used += crypto_needed
	_update_stat_label()
	upgrade_temp.emit(index_map[button_index], upgrade_amount)

func _on_upgrade_finalize() -> void:
	amount_plus_pressed = 0
	_update_stat_label()
