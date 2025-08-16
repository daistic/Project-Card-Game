extends Panel

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is OnScreenCard

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var scene_path: String = data.scene_file_path
	var card_scene: PackedScene = load(scene_path)
	BattleManager.add_to_player_deck(card_scene)
	SignalHub.emit_card_selected()
