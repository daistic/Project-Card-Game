extends Node

const CYBER_STORY = preload("res://Utilities/Battle Manager/Story/CyberStory.tres")
const CYBER_STORY_HARD = preload("res://Utilities/Battle Manager/Story/CyberStoryHard.tres")
const CARD_GAME: PackedScene = preload("res://Stages/Card Game/CardGame.tscn")
const BATTLE_WON_SCREEN: PackedScene = preload("res://Stages/After Battle/Battle Won/BattleWonScreen.tscn")
const BATTLE_LOST_SCREEN: PackedScene = preload("res://Stages/After Battle/Battle Lost/BattleLostScreen.tscn")

const MINIMUM_CRIT_RATE: float = 0.0
const MAXIMUM_CRIT_RATE: float = 100.0
const MAXIMUM_CARDS_ON_HAND: int = 5

var player: Player
var enemy: Enemy

var player_deck: Array[PackedScene] = []

var cur_story: StoryScript = CYBER_STORY
var battles_to_boss: int
var is_fighting_boss: bool = false
var story_index: int = 0

var story_messages_index: int = 0
var message_index: int = -1

var crypto_collected: int = 0

func _ready() -> void:
	set_starting_deck()
	reset_battle_manager()

func reset_battle_manager() -> void:
	is_fighting_boss = false
	story_index = 0
	story_messages_index = 0
	message_index = -1
	crypto_collected = 0

func set_story(is_hard_mode: bool) -> void:
	if is_hard_mode:
		cur_story = CYBER_STORY_HARD
	else:
		cur_story = CYBER_STORY
	
	battles_to_boss = cur_story.story[story_index].battles_to_meet

func set_starting_deck() -> void:
	player_deck.clear()
	
	var starting_deck: CardPackedList = Global.get_starting_deck()
	for scene in starting_deck.packed_scenes:
		add_to_player_deck(scene.duplicate())

func add_to_player_deck(card_scene: PackedScene) -> void:
	player_deck.append(card_scene.duplicate())

func draw_player_deck() -> PackedScene:
	return player_deck.pick_random()

func new_player(_new_player: Player) -> void:
	player = _new_player

func new_enemy(_new_enemy: Enemy) -> void:
	enemy = _new_enemy

func _boss_check() -> void:
	battles_to_boss -= 1
	
	if battles_to_boss < 0:
		is_fighting_boss = true
		story_index += 1
		if story_index < cur_story.story.size():
			battles_to_boss = cur_story.story[story_index].battles_to_meet
	else:
		is_fighting_boss = false

func get_random_normal_enemy() -> PackedScene:
	return cur_story.normal_enemies.pick_random()

func get_story_boss() -> PackedScene:
	return cur_story.story[story_index - 1].next_boss

func get_formatted_story_message() -> String:
	message_index += 1
	
	if message_index >= cur_story.story[story_messages_index].story_messages.size():
		message_index = 0
		story_messages_index += 1
	
	var message: String = cur_story.story[story_messages_index].story_messages[message_index]
	
	if message.contains("%"):
		message = message % battles_to_boss
	
	return message

func go_to_card_game() -> void:
	_boss_check()
	get_tree().change_scene_to_packed(CARD_GAME)

func go_to_battle_won_screen() -> void:
	reset_stats()
	get_tree().change_scene_to_packed(BATTLE_WON_SCREEN)

func go_to_battle_lost_screen() -> void:
	reset_stats()
	get_tree().change_scene_to_packed(BATTLE_LOST_SCREEN)

func reset_stats() -> void:
	player.stats.reset_stats()
	enemy.stats.reset_stats()

func handle_next_game_scene() -> void:
	go_to_card_game()

func get_crypto_collected() -> int:
	return crypto_collected
