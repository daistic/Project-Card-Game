extends TextureRect

@onready var cryto_label: Label = $Parallax/Screen/MarginContainer/VBoxContainer/VBoxContainer/CrytoLabel
@onready var parallax: Control = $Parallax

@export var max_parallax_offset: Vector2 = Vector2(2.5, 2.5)
@export var smoothing: float = 5.0

func _ready() -> void:
	cryto_label.text = "Cryto Collected: %d" % BattleManager.get_crypto_collected()
	Global.save_player_data(Global.get_total_crypto() + BattleManager.get_crypto_collected())

func _on_main_button_pressed() -> void:
	Global.go_to_main_menu()
