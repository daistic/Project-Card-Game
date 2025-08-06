extends Node

signal card_used(on_screen_card: CardProperties)

func _emit_on_card_used(_on_screen_card: CardProperties) -> void:
	card_used.emit(_on_screen_card)
