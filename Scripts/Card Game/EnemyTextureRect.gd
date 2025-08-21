extends ColorRect

@onready var shadow: TextureRect = $Shadow
@onready var enemy_texture: TextureRect = $EnemyTexture

@export var max_parallax_offset: Vector2 = Vector2(2.5, 2.5)
@export var smoothing: float = 5.0

const MAX_SHADOW_OFFSET: float = 20.0

func _process(_delta: float) -> void:
	_handle_shadow()

func _handle_shadow() -> void:
	var center: Vector2 = get_viewport_rect().size / 2.0
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	
	var distance: float = enemy_texture.global_position.x - center.x
	var shadow_offset_x: float= lerp(0.0, -sign(distance) * MAX_SHADOW_OFFSET, abs(distance / center.x))
	
	var dampener: float = 0.35
	var mouse_dir: Vector2 = (mouse_pos - center) / center
	var shadow_offset_mouse := mouse_dir * MAX_SHADOW_OFFSET * dampener
	
	var target_offset: Vector2 = Vector2(shadow_offset_x, 0.0) + shadow_offset_mouse
	
	shadow.position = shadow.position.lerp(target_offset, 0.1)
