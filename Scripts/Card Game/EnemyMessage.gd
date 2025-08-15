extends TextureRect

@onready var label: Label = $ScrollContainer/Label
var active_enemy: Enemy

func _ready() -> void:
	SignalHub.enemy_finished_calculations.connect(_on_enemy_finished_calculations)

func _on_enemy_finished_calculations() -> void:
	active_enemy = BattleManager.enemy
	label.text = "Next Enemy Moves:\n"
	
	for card in active_enemy.next_cards:
		label.text += "- %s\n" % [card.name]
