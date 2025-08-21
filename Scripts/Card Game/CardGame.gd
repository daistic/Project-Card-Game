class_name CardGame

extends Control

@onready var parallax: Control = $Parallax
@onready var paused_layer: ColorRect = $PausedLayer

@export var max_parallax_offset: Vector2
@export var smoothing: float = 2.0

func _enter_tree() -> void:
	SignalHub.battle_won.connect(_on_battle_won)
	SignalHub.battle_lost.connect(_on_battle_lost)

func _ready() -> void:
	_new_enemy()

func _process(delta: float) -> void:
	_handle_parallax_effect(delta)

func _handle_parallax_effect(delta: float) -> void:
	var center: Vector2 = get_viewport_rect().size / 2.0
	var dist: Vector2 = get_global_mouse_position() - center
	var offset: Vector2 = dist / center
	
	var new_pos: Vector2
	
	new_pos.x = lerp(max_parallax_offset.x, -max_parallax_offset.x, offset.x)
	new_pos.y = lerp(max_parallax_offset.y, -max_parallax_offset.y, offset.y)
	
	parallax.position.x = lerp(parallax.position.x, new_pos.x, smoothing * delta)
	parallax.position.y = lerp(parallax.position.y, new_pos.y, smoothing * delta) 

func _new_enemy() -> void:
	var enemy_scene: PackedScene
	
	if BattleManager.is_fighting_boss:
		enemy_scene = BattleManager.get_story_boss()
	else:
		enemy_scene= Global.get_random_enemy()
	
	var instance: Enemy = enemy_scene.instantiate()
	parallax.add_child(instance)

func _on_battle_won() -> void:
	BattleManager.go_to_battle_won_screen()

func _on_battle_lost() -> void:
	BattleManager.go_to_battle_lost_screen()

func _on_pause_button_pressed() -> void:
	paused_layer.show()

func _on_continue_button_pressed() -> void:
	paused_layer.hide()

func _on_quit_button_pressed() -> void:
	BattleManager.go_to_battle_lost_screen()
