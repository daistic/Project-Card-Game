extends Node

var full_gimmick_message: String = ""

func _enter_tree() -> void:
	SignalHub.gimmick_finished_calculations.connect(_on_gimmick_finished_calculations)

func _on_gimmick_finished_calculations() -> void:
	full_gimmick_message = ""
	
	for gimmick in get_children():
		if gimmick is EnemyGimmick:
			if gimmick.has_message:
				full_gimmick_message += gimmick.get_formatted_message()
	
	SignalHub.emit_gimmick_message_sent(full_gimmick_message)
