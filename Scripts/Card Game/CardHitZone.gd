class_name CardHitZone

extends Panel

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is CardInterface:
		if (BattleManager.player.cur_energy - data.energy_cost < 0 or 
			BattleManager.player.cur_ai_energy - data.ai_energy_cost < 0):
				return false
		else:
			return true
	else:
		return false

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	SignalHub.emit_card_used(data)
