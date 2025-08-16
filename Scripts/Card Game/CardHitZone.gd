class_name CardHitZone

extends Panel

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is OnScreenCard:
		if (BattleManager.player.cur_energy - data.card_resource.energy_cost < 0 or 
			BattleManager.player.cur_ai_energy - data.card_resource.ai_energy_cost < 0):
				return false
		else:
			return true
	else:
		return false

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var _card_resource: CardInterface = data.card_resource
	
	SignalHub.emit_card_used(_card_resource)
