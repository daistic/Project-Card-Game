class_name CardGame

extends Control

@onready var background: ColorRect = $Background
@onready var player_parallax: Control = $PlayerParallax
@onready var enemy_parallax: Control = $EnemyParallax
@onready var paused_layer: ColorRect = $PausedLayer

func _enter_tree() -> void:
	SignalHub.battle_won.connect(_on_battle_won)
	SignalHub.battle_lost.connect(_on_battle_lost)

func _ready() -> void:
	_new_enemy()
	SoundManager.play_bgm("Battle")

func _new_enemy() -> void:
	var enemy_scene: PackedScene
	
	if BattleManager.is_fighting_boss:
		enemy_scene = BattleManager.get_story_boss()
	else:
		enemy_scene = BattleManager.get_random_normal_enemy()
	
	var instance: Enemy = enemy_scene.instantiate()
	enemy_parallax.add_child(instance)

func _on_battle_won() -> void:
	BattleManager.go_to_battle_won_screen()

func _on_battle_lost() -> void:
	BattleManager.go_to_battle_lost_screen()

func _on_pause_button_pressed() -> void:
	paused_layer.show()
	SoundManager.play_sfx("Pause")

func _on_continue_button_pressed() -> void:
	paused_layer.hide()

func _on_quit_button_pressed() -> void:
	BattleManager.go_to_battle_lost_screen()
