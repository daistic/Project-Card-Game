extends TextureRect

@onready var exit_button: GameButton = $ExitButton
@onready var music_slider: HSlider = $VBoxContainer/HBoxContainer/MusicSlider
@onready var sfx_slider: HSlider = $VBoxContainer/HBoxContainer2/SFXSlider

func _ready() -> void:
	music_slider.value = SoundManager.bgm_volume
	sfx_slider.value = SoundManager.sfx_volume

func _on_exit_button_pressed() -> void:
	exit_button._reset_modulate()
	call_deferred("hide")
	Global.save_settings_data()

func _on_music_slider_value_changed(value: float) -> void:
	SoundManager.set_bgm_volume(value)

func _on_sfx_slider_value_changed(value: float) -> void:
	SoundManager.set_sfx_volume(value)
