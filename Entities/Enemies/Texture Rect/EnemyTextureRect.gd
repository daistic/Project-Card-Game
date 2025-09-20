class_name EnemyRect

extends ColorRect

@onready var shadow: TextureRect = $Shadow
@onready var enemy_texture: TextureRect = $EnemyTexture

@export var max_parallax_offset: Vector2 = Vector2(2.5, 2.5)
@export var smoothing: float = 5.0

const MAX_SHADOW_OFFSET: float = 35.0

func _enter_tree() -> void:
	call_deferred("_start_idle_animation")

func _process(_delta: float) -> void:
	_handle_shadow()

func _handle_shadow() -> void:
	var center: Vector2 = get_viewport_rect().size * 0.5
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()

	# Horizontal offset based on enemy vs shadow difference
	var distance_x: float = enemy_texture.position.x - shadow.position.x
	var shadow_offset_x: float = lerp(
		0.0,
		-sign(distance_x) * MAX_SHADOW_OFFSET,
		clamp(abs(distance_x / center.x), 0.0, 1.0)
	)

	# Mouse offset dampened
	var dampener: float = 0.35
	var mouse_dir: Vector2 = (mouse_pos - center) / center
	var shadow_offset_mouse: Vector2 = mouse_dir * MAX_SHADOW_OFFSET * dampener

	# Final target offset relative to enemy
	var target_offset: Vector2 = Vector2(shadow_offset_x, 0.0) + shadow_offset_mouse

	# Lerp towards enemy_texture position + offset
	shadow.global_position = shadow.global_position.lerp(
		enemy_texture.global_position + target_offset,
		0.1
	)


func _start_idle_animation() -> void:
	if not is_instance_valid(enemy_texture) or not is_instance_valid(shadow):
		return
	
	var tween: Tween = create_tween()
	tween.set_loops()
	
	tween.tween_property(enemy_texture, "scale", Vector2(1.1, 1.1), 1.35).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(enemy_texture, "position:y", enemy_texture.position.y - 5, 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(enemy_texture, "scale", Vector2(1.0, 1.0), 1.35).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(enemy_texture, "position:y", enemy_texture.position.y + 5, 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.parallel().tween_property(shadow, "scale", Vector2(1.1, 1.1), 1.35).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(shadow, "position:y", shadow.position.y - 3, 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.parallel().tween_property(shadow, "scale", Vector2(1.0, 1.0), 1.35).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(shadow, "position:y", shadow.position.y + 3, 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func play_death_animation() -> Signal:
	var tween: Tween = create_tween()
	tween.tween_property(enemy_texture, "modulate:a", 0.0, 1.0)
	tween.tween_property(shadow, "modulate:a", 0.0, 1.0)
	return tween.finished
