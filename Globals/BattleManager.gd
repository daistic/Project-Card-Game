extends Node

var player: Player = null
var enemy: Enemy = null

enum BATTLE_STATE {
	PLAYER_TURN,
	ENEMY_TURN
}

var current_state: BATTLE_STATE = BATTLE_STATE.PLAYER_TURN

const MINIMUM_CRIT_RATE: float = 0.0
const MAXIMUM_CRIT_RATE: float = 100.0

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
