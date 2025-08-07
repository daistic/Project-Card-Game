extends Node

var player: Player = Player.new()

enum BATTLE_STATE {
	PLAYER_TURN,
	ENEMY_TURN
}

var current_state: BATTLE_STATE = BATTLE_STATE.PLAYER_TURN

const MINIMUM_CRIT_RATE: float = 0.0
const MAXIMUM_CRIT_RATE: float = 100.0

func calculate_damage(atk: float, card_damage: float, enemy_shield: float, crit_rate: float,
						crit_damage: float) -> float:
	
	var total_damage: float = 0.0
	
	total_damage += (atk * card_damage) / enemy_shield
	
	var actual_crit_rate = clampf(crit_rate, MINIMUM_CRIT_RATE, MAXIMUM_CRIT_RATE)
	if randf_range(MINIMUM_CRIT_RATE, MAXIMUM_CRIT_RATE) <= actual_crit_rate:
		total_damage *= crit_damage
	
	return total_damage

func change_state(new_state: BATTLE_STATE) -> void:
	current_state = new_state
	match current_state:
		BATTLE_STATE.PLAYER_TURN:
			pass
		BATTLE_STATE.ENEMY_TURN:
			SignalHub.emit_switch_to_enemy_state()
		_:
			print("signal not found")
