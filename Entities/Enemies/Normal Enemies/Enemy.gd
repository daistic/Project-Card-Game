class_name Enemy

extends Control

@onready var enemy_bars: BattleBars = $VBoxContainer/EnemyBarsContainer
@onready var enemy_message: EnemyMessage = $EnemyMessage
@onready var status_effect_container: StatusEffectGrid = $VBoxContainer/HBoxContainer/StatusEffectGrid

@export var stats: Damageable
@export var enemy_deck: Array[CardInterface] = []
@export var max_moves: int = 2
@export var crypto_price: int = 1000

var discard_deck: Array[CardInterface] = []

func _enter_tree() -> void:
	SignalHub.card_used.connect(_on_card_used)
	SignalHub.enemy_card_used.connect(_on_enemy_card_used)
	SignalHub.player_turn_finished.connect(_on_player_turn_finished)
	SignalHub.enemy_turn_finished.connect(_on_enemy_turned_finished)

func _ready() -> void:
	_enemy_setup()
	BattleManager.new_enemy(self)

func _enemy_setup() -> void:
	stats.reset_stats()
	_shuffle_deck()
	enemy_bars.bars_setup(stats.max_hp, stats.max_shield)
	_update_enemy_bars()

func _on_card_used(_card_resource: CardInterface) -> void:
	_card_resource.degenerate_stat(stats)
	
	var player_stats: Damageable = BattleManager.player.stats.get_stats_after_status()
	stats.cur_hp -= stats.card_damage(player_stats, 
		_card_resource.get_card_damage(player_stats), enemy_bars.circle, true)
	
	_update_enemy_bars()
	_check_health()

func _on_enemy_card_used(_card_resource: CardInterface) -> void:
	_card_resource.regenerate_stat(stats)
	
	if _card_resource is StatusEffector:
		if _card_resource.is_debuff:
			BattleManager.player.new_status_effect(_card_resource)
		else:
			new_status_effect(_card_resource)
	
	_card_resource.play_sfx()
	
	_update_enemy_bars()

func _on_player_turn_finished() -> void:
	var move_played: int = 0
	
	while(move_played < max_moves):
		SignalHub.emit_enemy_card_used(enemy_deck[0])
		discard_deck.append(enemy_deck.pop_front())
		move_played += 1
	
	SignalHub.emit_enemy_turn_finished()

func _on_enemy_turned_finished() -> void:
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
	
	_shuffle_deck()

func _shuffle_deck() -> void:
	if enemy_deck.size() < max_moves:
		_reset_deck()
	
	enemy_deck.shuffle()
	enemy_message.update_next_move_label(enemy_deck, max_moves)

func _reset_deck() -> void:
	while discard_deck.size() > 0:
		enemy_deck.append(discard_deck.pop_front())

func new_status_effect(_card_resource: StatusEffector) -> void:
	if _card_resource.can_be_applied(stats):
		var status_effect: StatusEffector = _card_resource.duplicate()
		stats.status_effects.append(status_effect)
		_card_resource.on_appended()
		status_effect_container.add_status_effect_ui(status_effect)

func _check_health() -> void:
	if stats.cur_hp <= 0:
		_reset_deck()
		
		BattleManager.crypto_collected += crypto_price
		stats.reset_stats()
		SignalHub.call_deferred("emit_battle_won")

func _update_enemy_bars() -> void:
	enemy_bars.update_bars(stats.cur_hp, stats.cur_shield)
