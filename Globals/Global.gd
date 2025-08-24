extends Node

const CARDS_LIST: CardsList = preload("res://Resources/Cards List/CardFileList.tres")
const STARTING_DECK: CardPackedList = preload("res://Resources/Decks/StartingDeck.tres")
const WINNER_DECK: CardPackedList = preload("res://Resources/Decks/WinnerDeck.tres")
const MALWAREDECK: CardPackedList = preload("res://Resources/Decks/MalwareDeck.tres")
const ENEMY_LIST: Array[PackedScene] = [
	preload("res://Scenes/Enemies/Enemy1.tscn"),
	preload("res://Scenes/Enemies/Enemy2.tscn"),
	preload("res://Scenes/Enemies/Enemy3.tscn"),
	preload("res://Scenes/Enemies/Enemy3.tscn")
]
const SAVE_PATH: String = "user://save_data.tres"
const MAIN_MENU: PackedScene = preload("res://Scenes/MainMenu/MainMenu.tscn")
const PROLOGUE: PackedScene = preload("res://Scenes/Cutscenes/Prologue.tscn")
const EPILOGUE: PackedScene = preload("res://Scenes/Cutscenes/Epilogue.tscn")

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

func save_data(_total_crypto: int = total_crypto,
		_player_stats: Damageable = player_stats) -> void:
	player_stats = _player_stats
	total_crypto = _total_crypto
	
	var data = SaveData.new()
	data.player_stats = player_stats
	data.total_cryto = _total_crypto
	data.bgm_volume = SoundManager.bgm_volume
	data.sfx_volume = SoundManager.sfx_volume
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

func go_to_main_menu() -> void:
	get_tree().change_scene_to_packed(MAIN_MENU)

func go_to_prologue() -> void:
	get_tree().change_scene_to_packed(PROLOGUE)

func go_to_epilogue() -> void:
	get_tree().change_scene_to_packed(EPILOGUE)
