extends TextureRect

@onready var exit_button: GameButton = $ExitButton

func _on_exit_button_pressed() -> void:
	exit_button._reset_modulate()
	call_deferred("hide")
