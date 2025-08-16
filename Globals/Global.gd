extends Node

const CARDS_LIST: CardsList = preload("res://Resources/Cards List/CardFileList.tres")
const STARTING_DECK: CardPackedList = preload("res://Resources/Decks/StartingDeck.tres")
const WINNER_DECK: CardPackedList = preload("res://Resources/Decks/WinnerDeck.tres")
const ENEMY_LIST: Array[PackedScene] = [
	preload("res://Scenes/Enemies/Enemy1.tscn"),
	preload("res://Scenes/Enemies/Enemy2.tscn")
]

var cards_scene: Array[PackedScene]= []
var cards_resources: Array[CardInterface] = []

enum CARDS_TYPE{
	Basic_ATK,
	Basic_HEAL,
	Basic_SHIELD
}

func _enter_tree() -> void:
	pass
	#for fn in CARDS_LIST.file_names:
		#cards_scene.append(load(fn.scene_path))
		#cards_resources.append(load(fn.card_resource_path))

func get_starting_deck() -> CardPackedList:
	return STARTING_DECK

func get_random_enemy() -> PackedScene:
	return ENEMY_LIST.pick_random()

func get_3_random_winner_cards() -> Array[PackedScene]:
	var winner_deck: Array[PackedScene] = WINNER_DECK.packed_scenes
	winner_deck.shuffle()
	return [winner_deck[0], winner_deck[1], winner_deck[2]]
