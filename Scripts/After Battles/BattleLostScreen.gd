extends TextureRect

@onready var cryto_label: Label = $Parallax/Screen/MarginContainer/VBoxContainer/VBoxContainer/CrytoLabel
@onready var parallax: Control = $Parallax

@export var max_parallax_offset: Vector2 = Vector2(2.5, 2.5)
@export var smoothing: float = 5.0

func _ready() -> void:
	cryto_label.text = "Cryto Collected: %d" % BattleManager.get_crypto_collected()
	Global.save_player_data(Global.get_total_crypto() + BattleManager.get_crypto_collected())

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

func _on_main_button_pressed() -> void:
	Global.go_to_main_menu()
