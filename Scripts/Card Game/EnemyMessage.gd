extends TextureRect

@onready var label: Label = $ScrollContainer/Label
@onready var gimmick_label: Label = $ScrollContainer2/GimmickLabel

var active_enemy: Enemy
var is_not_ready: bool = true

func _enter_tree() -> void:
	SignalHub.enemy_finished_calculations.connect(_on_enemy_finished_calculations)
	SignalHub.gimmick_message_sent.connect(_on_gimmick_message_sent)

func _ready() -> void:
	is_not_ready = false

func _on_enemy_finished_calculations() -> void:
	check_readiness()
	
	active_enemy = BattleManager.enemy
	label.text = "Next Enemy Moves:\n"
	
	for card in active_enemy.next_cards:
		label.text += "- %s\n" % [card.name]

func _on_gimmick_message_sent(_message: String) -> void:
	check_readiness()
	gimmick_label.text = _message

func check_readiness() -> void:
	if is_not_ready:
		await ready
