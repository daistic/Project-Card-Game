class_name CardHitZone

extends Panel

func _enter_tree() -> void:
	SignalHub.battle_paused.connect(_on_battle_paused)

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is OnScreenCard:
		if (BattleManager.player.energy.current - data.card_resource.energy_cost < 0 or 
			BattleManager.player.ai_energy.current - data.card_resource.ai_energy_cost < 0):
				data.play_cant_use_sfx()
				return false
		else:
			return true
	else:
		return false

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var _card_resource: CardInterface = data.card_resource
	
	SignalHub.emit_card_used(_card_resource)

func _on_battle_paused() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
