class_name PlayScreen

extends TextureRect

signal mode_selected

func _on_mode_selected(is_hard_mode: bool) -> void:
	BattleManager.reset_battle_manager()
	BattleManager.set_story(is_hard_mode)
	BattleManager.set_starting_deck()
	Global.load_data()

func _on_exit_button_pressed() -> void:
	hide()

func _on_normal_mode_pressed() -> void:
	_on_mode_selected(false)
	mode_selected.emit()

func _on_hard_mode_pressed() -> void:
	_on_mode_selected(true)
	mode_selected.emit()
