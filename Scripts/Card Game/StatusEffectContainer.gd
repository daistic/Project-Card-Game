class_name StatusEffectGrid

extends GridContainer

const STATUS_EFFECT_UI = preload("res://Scenes/Card Game/StatusEffectUi.tscn")

@export var buff_texture: CompressedTexture2D
@export var debuff_texture: CompressedTexture2D
@export var malware_texture: CompressedTexture2D
@export var is_enemy_status_effect: bool = false

var effect_ui_map: Dictionary = {}

func add_status_effect_ui(effect: StatusEffector) -> void:
	var ui_texture: CompressedTexture2D
	
	if effect.is_debuff:
		ui_texture = debuff_texture
	else:
		ui_texture = buff_texture
	if effect.is_malware:
		ui_texture = malware_texture
	
	var ui: StatusEffectUI = STATUS_EFFECT_UI.instantiate()
	ui.setup_ui(ui_texture, effect, is_enemy_status_effect)
	add_child(ui)
	effect_ui_map[effect] = ui

func update_ui_desc(effect: StatusEffector) -> void:
	if effect in effect_ui_map:
		var ui: StatusEffectUI = effect_ui_map[effect]
		ui.update_desc()

func remove_status_effect_ui(effect: StatusEffector) -> void:
	if effect in effect_ui_map:
		var ui: StatusEffectUI = effect_ui_map[effect]
		ui.queue_free()
		effect_ui_map.erase(effect)
