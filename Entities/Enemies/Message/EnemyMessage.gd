class_name EnemyMessage

extends TextureRect

@onready var label: Label = $ScrollContainer/Label
@onready var gimmick_label: Label = $ScrollContainer2/GimmickLabel

func _enter_tree() -> void:
	SignalHub.gimmick_message_sent.connect(_on_gimmick_message_sent)

func update_next_move_label(enemy_deck: Array[CardInterface], moves: int) -> void:
	label.text = "Next Enemy Moves:\n"
	
	var move_number: int = 0
	while(move_number < moves):
		label.text += "- %s\n" % [enemy_deck[move_number].name]
		move_number += 1

func _on_gimmick_message_sent(_message: String) -> void:
	gimmick_label.text = _message
