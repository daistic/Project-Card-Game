extends Control

@onready var parallax: Control = $Parallax
@onready var upgrade_screen: TextureRect = $Parallax/UpgradeScreen
@onready var credit_screen: TextureRect = $Parallax/CreditScreen
@onready var how_to_screen: TextureRect = $Parallax/HowToScreen
@onready var settings_screen: TextureRect = $Parallax/SettingsScreen
@onready var reset_layer: ResetLayer = $ResetLayer
@onready var fade: ColorRect = $PostProcessing/Fade
@onready var fade_animation: AnimationPlayer = $PostProcessing/Fade/FadeAnimation

@export var max_parallax_offset: Vector2 = Vector2(2.5, 2.5)
@export var smoothing: float = 5

var current_screen: Control = Control.new()

func _ready() -> void:
	SoundManager.play_bgm("Menu")

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

func handle_screen_display(new_screen: Control) -> void:
	current_screen.hide()
	current_screen = new_screen
	new_screen.show()
	SoundManager.play_sfx("Button Click")

func _on_start_pressed() -> void:
	BattleManager.reset_battle_manager()
	BattleManager.clear_player_deck()
	BattleManager.set_starting_deck()
	Global.load_data()
	
	fade.show()
	fade_animation.play("Fade")
	await fade_animation.animation_finished
	
	Global.go_to_prologue()

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
