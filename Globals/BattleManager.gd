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
