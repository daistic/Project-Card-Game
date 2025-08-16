extends Node

const MINIMUM_CRIT_RATE: float = 0.0
const MAXIMUM_CRIT_RATE: float = 100.0
const MAXIMUM_CARDS_ON_HAND: int = 5

var game_scene: CardGame
var player: Player
var enemy: Enemy

var player_deck: Array[PackedScene] = []

func _enter_tree() -> void:
	var starting_deck: CardPackedList = Global.get_starting_deck()
	for scene in starting_deck.packed_scenes:
		player_deck.append(scene)

func draw_player_deck() -> PackedScene:
	return player_deck.pick_random()

func card_game_ready(scene: CardGame) -> void:
	game_scene = scene

func new_player(_new_player: Player) -> void:
	player = _new_player

func new_enemy(_new_enemy: Enemy) -> void:
	enemy = _new_enemy

func add_to_player_deck(card_scene: PackedScene) -> void:
	player_deck.append(card_scene)
