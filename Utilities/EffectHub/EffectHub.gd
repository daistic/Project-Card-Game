extends Node

const DAMAGE_NUMBER_FONT: LabelSettings = preload("res://Utilities/EffectHub/DamageNumberFont.tres")

func display_damage(value: float, parent: Node, enemy_damaged: bool,
	is_critical: bool = false) -> void:
	var number: Label = Label.new()
	number.text = "%.1f" % value
	number.z_index = 6
	number.label_settings = DAMAGE_NUMBER_FONT.duplicate()
	
	var color: String = "#FFF"
	if is_critical:
		color = "#FFAC1C"
	if value == 0:
		color = "#ffffff00"
	
	number.label_settings.font_color = color
	parent.call_deferred("add_child", number)
	if value > 0:
		if enemy_damaged == false:
			trigger_camera_shake()
		else:
			trigger_slash_effect(is_critical)
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var y_offset: float = 48
	if enemy_damaged:
		y_offset = -y_offset
	var random_time: float = randf_range(0.15, 0.75)
	
	var tween: Tween = get_tree().current_scene.create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position:y", number.position.y - y_offset, random_time
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "scale", Vector2.ZERO, random_time
	).set_ease(Tween.EASE_IN).set_delay(0.5)
	
	await tween.finished
	number.queue_free()

func trigger_camera_shake() -> void:
	var game_camera: GameCamera = get_tree().get_first_node_in_group("Camera")
	
	if game_camera == null:
		return
	
	game_camera.trigger_shake()

func trigger_slash_effect(is_critical: bool) -> void:
	var slash_effect: AnimatedSprite2D = get_tree().get_first_node_in_group("Slash")
	
	if is_critical:
		slash_effect.modulate = "#FFAC1C"
	else:
		slash_effect.modulate = "#FFF"
	
	slash_effect.stop()
	slash_effect.play("slash")

func handle_attack_sfx(damage: float, is_crit: bool, enemy_damaged: bool) -> void:
	if damage <= 0:
		return
	
	if is_crit:
		SoundManager.play_attack_sfx("Crit")
	else:
		if enemy_damaged:
			SoundManager.play_attack_sfx("Player Attack")
		else:
			SoundManager.play_attack_sfx("Enemy Attack")
