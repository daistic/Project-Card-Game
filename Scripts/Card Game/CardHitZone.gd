class_name CardHitZone

extends Panel

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is CardProperties

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	SignalHub.emit_card_used(data)
