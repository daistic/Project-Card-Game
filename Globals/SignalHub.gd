extends Node

signal card_used(properties: CardProperties)

func _emit_on_card_used(_properties: CardProperties) -> void:
	card_used.emit(_properties)
