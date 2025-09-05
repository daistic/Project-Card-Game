extends Control

@onready var parallax: Control = $Parallax
@onready var upgrade_screen: TextureRect = $Parallax/UpgradeScreen
@onready var credit_screen: TextureRect = $Parallax/CreditScreen
@onready var how_to_screen: TextureRect = $Parallax/HowToScreen
@onready var settings_screen: TextureRect = $Parallax/SettingsScreen
@onready var play_screen: PlayScreen = $Parallax/PlayScreen
@onready var reset_layer: ResetLayer = $ResetLayer
@onready var fade: ColorRect = $PostProcessing/Fade
@onready var fade_animation: AnimationPlayer = $PostProcessing/Fade/FadeAnimation

var current_screen: Control = Control.new()

func _ready() -> void:
	SoundManager.play_bgm("Menu")

func handle_screen_display(new_screen: Control) -> void:
	current_screen.hide()
	current_screen = new_screen
	new_screen.show()
	SoundManager.play_sfx("Button Click")

func _on_start_pressed() -> void:
	play_screen.show()

func _on_upgrade_pressed() -> void:
	handle_screen_display(upgrade_screen)

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_setting_pressed() -> void:
	handle_screen_display(settings_screen)

func _on_how_to_pressed() -> void:
	handle_screen_display(how_to_screen)

func _on_credits_pressed() -> void:
	handle_screen_display(credit_screen)

func _on_reset_button_pressed() -> void:
	reset_layer.show()
	reset_layer.fade_in()

func _on_play_screen_mode_selected() -> void:
	fade.show()
	fade_animation.play("Fade")
	await fade_animation.animation_finished
	
	Global.go_to_prologue()
