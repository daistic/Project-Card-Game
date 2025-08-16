extends Node

const CYBER_STORY = preload("res://Resources/StoryScript/CyberStory.tres")
const BATTLE_WON_SCREEN = preload("res://Scenes/After Battle/BattleWonScreen.tscn")
const CARD_GAME = preload("res://Scenes/Card Game/CardGame.tscn")

const MINIMUM_CRIT_RATE: float = 0.0
const MAXIMUM_CRIT_RATE: float = 100.0
const MAXIMUM_CARDS_ON_HAND: int = 5

var game_scene: CardGame
var player: Player
var enemy: Enemy

var player_deck: Array[PackedScene] = []
var battles_to_boss: int
var is_fighting_boss: bool = false

func _enter_tree() -> void:
	var starting_deck: CardPackedList = Global.get_starting_deck()
	for scene in starting_deck.packed_scenes:
		player_deck.append(scene)

func _ready() -> void:
	battles_to_boss = CYBER_STORY.story[0].battles_to_meet

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

func go_to_card_game() -> void:
	get_tree().change_scene_to_packed(CARD_GAME)

func go_to_battle_won_screen() -> void:
	get_tree().change_scene_to_packed(BATTLE_WON_SCREEN)
