extends Node

const CYBER_STORY: StoryScript = preload("res://Resources/StoryScript/CyberStory.tres")
const CARD_GAME: PackedScene = preload("res://Scenes/Card Game/CardGame.tscn")
const BATTLE_WON_SCREEN: PackedScene = preload("res://Scenes/After Battle/BattleWonScreen.tscn")
const BATTLE_LOST_SCREEN: PackedScene = preload("res://Scenes/After Battle/BattleLostScreen.tscn")

const MINIMUM_CRIT_RATE: float = 0.0
const MAXIMUM_CRIT_RATE: float = 100.0
const MAXIMUM_CARDS_ON_HAND: int = 5

var player: Player
var enemy: Enemy

var player_deck: Array[PackedScene] = []
var battles_to_boss: int
var is_fighting_boss: bool = false
var story_index: int = 0

var story_messages_index: int = 0
var message_index: int = -1

var crypto_collected: int = 0

func _ready() -> void:
	set_starting_deck()
	battles_to_boss = CYBER_STORY.story[story_index].battles_to_meet

func set_starting_deck() -> void:
	var starting_deck: CardPackedList = Global.get_starting_deck()
	for scene in starting_deck.packed_scenes:
		add_to_player_deck(scene.duplicate())

func clear_player_deck() -> void:
	player_deck.clear()

func add_to_player_deck(card_scene: PackedScene) -> void:
	player_deck.append(card_scene.duplicate())

func draw_player_deck() -> PackedScene:
	return player_deck.pick_random()

func new_player(_new_player: Player) -> void:
	player = _new_player

func new_enemy(_new_enemy: Enemy) -> void:
	enemy = _new_enemy

func on_battle_finished() -> void:
	player = null
	enemy = null

func _boss_check() -> void:
	battles_to_boss -= 1
	
	if battles_to_boss < 0:
		is_fighting_boss = true
		story_index += 1
		if story_index < CYBER_STORY.story.size():
			battles_to_boss = CYBER_STORY.story[story_index].battles_to_meet
	else:
		is_fighting_boss = false

func get_story_boss() -> PackedScene:
	return CYBER_STORY.story[story_index - 1].next_boss

func get_formatted_story_message() -> String:
	message_index += 1
	
	if message_index >= CYBER_STORY.story[story_messages_index].story_messages.size():
		message_index = 0
		story_messages_index += 1
	
	var message: String = CYBER_STORY.story[story_messages_index].story_messages[message_index]
	
	if message.contains("%"):
		message = message % battles_to_boss
	
	return message

func go_to_card_game() -> void:
	_boss_check()
	get_tree().change_scene_to_packed(CARD_GAME)

func go_to_battle_won_screen() -> void:
	get_tree().change_scene_to_packed(BATTLE_WON_SCREEN)

func go_to_battle_lost_screen() -> void:
	get_tree().change_scene_to_packed(BATTLE_LOST_SCREEN)

func handle_next_win_scene() -> void:
	if story_index < CYBER_STORY.story.size():
		go_to_card_game()
	else:
		Global.go_to_epilogue()

func get_crypto_collected() -> int:
	return crypto_collected
