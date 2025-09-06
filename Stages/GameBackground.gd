extends Background

func _do_background_logic() -> void:
	if BattleManager.is_fighting_boss:
		material = Global.get_background("Boss")
	else:
		material = Global.get_background("Normal")
