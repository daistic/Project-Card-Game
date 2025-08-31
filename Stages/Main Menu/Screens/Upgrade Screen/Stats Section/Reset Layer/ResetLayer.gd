class_name ResetLayer

extends ColorRect

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func fade_in() -> void:
	animation_player.play("Fade_In")

func _on_yes_pressed() -> void:
	Global.reset_save_data()
	get_tree().reload_current_scene()

func _on_no_pressed() -> void:
	animation_player.play("RESET")
	hide()
