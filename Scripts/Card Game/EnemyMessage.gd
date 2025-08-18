class_name EnemyMessage

extends TextureRect

@onready var label: Label = $ScrollContainer/Label
@onready var gimmick_label: Label = $ScrollContainer2/GimmickLabel

func _enter_tree() -> void:
	SignalHub.gimmick_message_sent.connect(_on_gimmick_message_sent)

func update_next_move_label(next_cards: Array[CardInterface]) -> void:
	label.text = "Next Enemy Moves:\n"
	
	for card in next_cards:
		label.text += "- %s\n" % [card.name]

func _on_gimmick_message_sent(_message: String) -> void:
	gimmick_label.text = _message
