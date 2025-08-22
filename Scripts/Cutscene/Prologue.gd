extends Control

@onready var parallax: Control = $Parallax
@onready var start: GameButton = $Start

@export var max_parallax_offset: Vector2 = Vector2(2.5, 2.5)
@export var smoothing: float = 5

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

func _on_start_pressed() -> void:
	BattleManager.go_to_card_game()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	start.show()
