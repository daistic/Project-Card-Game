extends Node

const CARDS_LIST: CardsList = preload("res://Resources/Cards List/CardFileList.tres")
const STARTING_DECK: CardPackedList = preload("res://Resources/Decks/StartingDeck.tres")
const WINNER_DECK: CardPackedList = preload("res://Resources/Decks/WinnerDeck.tres")
const MALWAREDECK: CardPackedList = preload("res://Resources/Decks/MalwareDeck.tres")
const ENEMY_LIST: Array[PackedScene] = [
	preload("res://Scenes/Enemies/Enemy1.tscn"),
	preload("res://Scenes/Enemies/Enemy2.tscn")
]
const SAVE_PATH: String = "user://save_data.tres"

var cards_scene: Array[PackedScene]= []
var cards_resources: Array[CardInterface] = []

var total_crypto: int = 0
var player_stats: Damageable

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

func _ready() -> void:
	load_data()

func load_data() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		var data: SaveData = ResourceLoader.load(SAVE_PATH)
		player_stats = data.player_stats
		total_crypto = data.total_cryto
	else:
		player_stats = load("res://Resources/Damageables/PlayerDamageable.tres")
		total_crypto = 0

func save_data(_player_stats: Damageable, _total_crypto: int) -> void:
	player_stats = _player_stats
	total_crypto = _total_crypto
	
	var data = SaveData.new()
	data.player_stats = player_stats
	data.total_cryto = _total_crypto
	ResourceSaver.save(data, SAVE_PATH)

func get_starting_deck() -> CardPackedList:
	return STARTING_DECK

func get_random_enemy() -> PackedScene:
	return ENEMY_LIST.pick_random()

func get_3_random_winner_cards() -> Array[PackedScene]:
	var winner_deck: Array[PackedScene] = WINNER_DECK.packed_scenes
	winner_deck.shuffle()
	return [winner_deck[0], winner_deck[1], winner_deck[2]]

func get_malware_deck() -> Array[PackedScene]:
	return MALWAREDECK.packed_scenes

func get_total_crypto() -> int:
	return total_crypto

func get_player_stats() -> Damageable:
	return player_stats
