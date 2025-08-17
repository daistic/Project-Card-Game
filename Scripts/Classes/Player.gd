class_name Player

extends Control

@onready var card_container: HBoxContainer = $PlayerInfoContainer/VBoxContainer/CardContainer
@onready var player_bars: BattleBars = $PlayerInfoContainer/VBoxContainer/VBoxContainer/PlayerBarsContainer
@onready var energy_info: EnergyInfo = $EnergyInfoContainer
@onready var status_effect_container: StatusEffectGrid = $PlayerInfoContainer/VBoxContainer/VBoxContainer/HBoxContainer/StatusEffectContainer

@export var stats: Damageable
@export var max_char_energy: int = 5
@export var max_ai_energy: int = 5

var cur_energy: int = 5
var cur_ai_energy: int = 5

func _enter_tree() -> void:
	SignalHub.card_used.connect(_on_card_used)
	SignalHub.enemy_card_used.connect(_on_enemy_card_used)
	SignalHub.player_turn_finished.connect(_on_player_turn_finished)
	SignalHub.enemy_turn_finished.connect(_on_enemy_turn_finished)

func _ready() -> void:
	_player_setup()
	BattleManager.new_player(self)
	SignalHub.emit_player_ready()

func _player_setup() -> void:
	stats.reset_stats()
	_draw_cards()
	player_bars.bars_setup(stats.max_hp, stats.max_shield)
	_update_player_bars()
	update_player_energy_info()

func _on_card_used(_card_resource: CardInterface) -> void:
	cur_energy -= _card_resource.energy_cost
	cur_ai_energy -= _card_resource.ai_energy_cost
	
	_card_resource.regenerate_stat(stats)
	if _card_resource is StatusEffector:
		if _card_resource.is_debuff:
			BattleManager.enemy.new_status_effect(_card_resource)
		else:
			new_status_effect(_card_resource)
	
	_update_player_bars()
	update_player_energy_info()

func _on_enemy_card_used(_card_resource: CardInterface) -> void:
	var enemy_stats: Damageable = BattleManager.enemy.stats.get_stats_after_status()
	
	stats.cur_hp -= stats.card_damage(enemy_stats, 
		_card_resource.get_card_damage(enemy_stats), player_bars.circle, false)
	
	_update_player_bars()
	_check_health()

func _on_player_turn_finished() -> void:
	for effect in stats.status_effects:
		if effect is StatusEffector:
			effect.turns -= 1
		
		if effect.turns <= 0:
			effect.on_erased()
			stats.status_effects.erase(effect)
			status_effect_container.remove_status_effect_ui(effect)
		else:
			effect.apply_effect()
			status_effect_container.update_ui_desc(effect)
	
	cur_energy = max_char_energy
	update_player_energy_info()
	#print(stats.status_effects)

func _on_enemy_turn_finished() -> void:
	_draw_cards()

func new_status_effect(_card_resource: StatusEffector) -> void:
	if _card_resource.can_be_applied(stats):
		var status_effect: StatusEffector = _card_resource.duplicate()
		stats.status_effects.append(status_effect)
		_card_resource.on_appended()
		status_effect_container.add_status_effect_ui(status_effect)

func _check_health() -> void:
	if stats.cur_hp <= 0:
		SignalHub.emit_battle_lost()

func clear_cards() -> void:
	for card in card_container.get_children():
		card.queue_free()

func _draw_cards() -> void:
	var draws: int  = 0
	
	while(draws < BattleManager.MAXIMUM_CARDS_ON_HAND):
		var card: OnScreenCard = BattleManager.draw_player_deck().instantiate()
		card_container.add_child(card)
		draws += 1

func _update_player_bars() -> void:
	player_bars.update_bars(stats.cur_hp, stats.cur_shield)

func update_player_energy_info() -> void:
	energy_info.update_energy_labels(self)

func _on_end_turn_button_pressed() -> void:
	clear_cards()
	SignalHub.emit_player_turn_finished()
