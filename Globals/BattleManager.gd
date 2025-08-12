extends Node

const STARTING_DECK: CardPackedList = preload("res://Resources/Cards List/StartingDeck.tres")
const MINIMUM_CRIT_RATE: float = 0.0
const MAXIMUM_CRIT_RATE: float = 100.0
const MAXIMUM_CARDS_ON_HAND: int = 5

var player: Player = null
var enemy: Enemy = null

var player_deck: Array[PackedScene] = []

func _enter_tree() -> void:
	for scene in STARTING_DECK.packed_scenes:
		player_deck.append(scene)

func draw_player_deck() -> PackedScene:
	return player_deck.pick_random()
