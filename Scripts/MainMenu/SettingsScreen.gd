extends TextureRect

@onready var exit_button: GameButton = $ExitButton

func _on_exit_button_pressed() -> void:
	exit_button._reset_modulate()
	call_deferred("hide")

func _on_music_slider_value_changed(value: float) -> void:
	SoundManager.set_bgm_volume(value)

func _on_sfx_slider_value_changed(value: float) -> void:
	SoundManager.set_sfx_volume(value)
