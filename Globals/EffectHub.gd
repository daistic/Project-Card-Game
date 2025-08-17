extends Node

const DAMAGE_NUMBER_FONT: LabelSettings = preload("res://Resources/Fonts/DamageNumberFont.tres")

func display_damage(value: float, position: Vector2, enemy_damaged: bool,
	is_critical: bool = false) -> void:
	var number: Label = Label.new()
	number.global_position = position
	number.text = "%.1f" % value
	number.z_index = 6
	number.label_settings = DAMAGE_NUMBER_FONT
	
	if is_critical:
		number.label_settings.font_color = "#B22"
	if value == 0:
		number.label_settings.font_color = "FFF8"
	
	call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var y_offset: float = 24
	if enemy_damaged:
		y_offset = -y_offset
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position:y", number.position.y - y_offset, 0.25
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "position:y", number.position.y, 0.5
	).set_ease(Tween.EASE_IN).set_delay(0.25)
	tween.tween_property(
		number, "scale", Vector2.ZERO, 0.25
	).set_ease(Tween.EASE_IN).set_delay(0.5)
	
	await tween.finished
	number.queue_free()
