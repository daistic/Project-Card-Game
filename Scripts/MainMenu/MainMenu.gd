extends Control

@onready var parallax: Control = $Parallax
@onready var upgrade_screen: TextureRect = $Parallax/UpgradeScreen

@export var max_parallax_offset: Vector2
@export var smoothing: float = 2.0
@export var Main:CanvasItem
@export var Upgrade:CanvasItem

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
	BattleManager.crypto_collected = 0

func _on_upgrade_pressed() -> void:
	upgrade_screen.show()

func _on_quit_pressed() -> void:
	pass # Replace with function body.

func _on_setting_pressed() -> void:
	pass # Replace with function body.

func _on_how_to_pressed() -> void:
	pass # Replace with function body.

func _on_credits_pressed() -> void:
	pass # Replace with function body.
