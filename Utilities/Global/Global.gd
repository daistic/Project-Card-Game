extends Node

const STARTING_DECK: CardPackedList = preload("res://Utilities/Global/Decks/StartingDeck.tres")
const WINNER_DECK: CardPackedList = preload("res://Utilities/Global/Decks/WinnerDeck.tres")
const MALWAREDECK: CardPackedList = preload("res://Utilities/Global/Decks/MalwareDeck.tres")

const SAVE_PATH: String = "user://save_data.tres"

const MAIN_MENU: PackedScene = preload("res://Stages/Main Menu/MainMenu.tscn")
const PROLOGUE: PackedScene = preload("res://Utilities/Cutscene/Prologue/Prologue.tscn")
const EPILOGUE: PackedScene = preload("res://Utilities/Cutscene/Epilogue/Epilogue.tscn")

const BACKGROUND_MAP: Dictionary[String, ShaderMaterial] = {
	"Normal": preload("res://Stages/NormalBG.tres"),
	"Boss": preload("res://Stages/BossBG.tres")
}

var cards_scene: Array[PackedScene]= []
var cards_resources: Array[CardInterface] = []

var save_data: SaveData

func _ready() -> void:
	load_data()

func load_data() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		var data: SaveData = ResourceLoader.load(SAVE_PATH)
		save_data = data
	else:
		save_data = load("res://Utilities/Save System/DefaultSaveData.tres").duplicate()

func save_player_data(_total_crypto: int = get_total_crypto(),
		_player_stats: Damageable = get_player_stats()) -> void:
	save_data.player_stats = _player_stats
	save_data.total_cryto = _total_crypto
	ResourceSaver.save(save_data, SAVE_PATH)

func save_settings_data() -> void:
	save_data.bgm_volume = SoundManager.bgm_volume
	save_data.sfx_volume = SoundManager.sfx_volume
	ResourceSaver.save(save_data, SAVE_PATH)

func save_upgrade_levels_data() -> void:
	ResourceSaver.save(save_data, SAVE_PATH)

func reset_save_data() -> void:
	var default_save_data: SaveData = load("res://Utilities/Save System/DefaultSaveData.tres").duplicate()
	save_player_data(default_save_data.total_cryto, default_save_data.player_stats)
	
	save_data.stat_levels = default_save_data.stat_levels
	save_upgrade_levels_data()

func get_starting_deck() -> CardPackedList:
	return STARTING_DECK

func get_3_random_winner_cards() -> Array[PackedScene]:
	var winner_deck: Array[PackedScene] = WINNER_DECK.packed_scenes
	winner_deck.shuffle()
	return [winner_deck[0], winner_deck[1], winner_deck[2]]

func get_malware_deck() -> Array[PackedScene]:
	return MALWAREDECK.packed_scenes

func get_total_crypto() -> int:
	return save_data.total_cryto

func get_player_stats() -> Damageable:
	return save_data.player_stats

func get_stat_levels() -> Array[int]:
	return save_data.stat_levels

func go_to_main_menu() -> void:
	get_tree().change_scene_to_packed(MAIN_MENU)

func go_to_prologue() -> void:
	get_tree().change_scene_to_packed(PROLOGUE)

func go_to_epilogue() -> void:
	get_tree().change_scene_to_packed(EPILOGUE)

func get_background(key: String) -> ShaderMaterial:
	if !BACKGROUND_MAP.has(key):
		return
	
	return BACKGROUND_MAP[key]
