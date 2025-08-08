extends Node

var player: Player = null
var enemy: Enemy = null

enum BATTLE_STATE {
	PLAYER_TURN,
	ENEMY_TURN
}

var current_state: BATTLE_STATE = BATTLE_STATE.PLAYER_TURN
var player_deck: Array[PackedScene] = Global.CARDS_LIST.starting_deck_scenes

const MINIMUM_CRIT_RATE: float = 0.0
const MAXIMUM_CRIT_RATE: float = 100.0
const MAXIMUM_CARDS_ON_HAND: int = 5

func _enter_tree() -> void:
	player_deck.append(Global.get_card_scene(Global.CARDS_TYPE.Basic_ATK))

func calculate_damage_to_self(other_damageable: Damageable, self_damageable: Damageable,
								card_damage: float) -> float:
	
	var total_damage: float = 0.0
	
	total_damage += (other_damageable.atk * card_damage) / self_damageable.shield
	
	var actual_crit_rate = clampf(other_damageable.crit_rate, MINIMUM_CRIT_RATE, 
									MAXIMUM_CRIT_RATE)
	if randf_range(MINIMUM_CRIT_RATE, MAXIMUM_CRIT_RATE) <= actual_crit_rate:
		total_damage *= other_damageable.crit_damage
	
	return total_damage

func change_state(new_state: BATTLE_STATE) -> void:
	current_state = new_state
	match current_state:
		BATTLE_STATE.PLAYER_TURN:
			SignalHub.emit_enemy_turn_finished()
		BATTLE_STATE.ENEMY_TURN:
			SignalHub.emit_player_turn_finished()
		_:
			print("signal not found")

func draw_from_player_deck() -> PackedScene:
	return player_deck.pick_random()
