class_name EnergyInfo

extends VBoxContainer

@onready var energy_label: Label = $EnergyTexture/EnergyLabel
@onready var ai_energy_label: Label = $AIEnergyTexture/AIEnergyLabel

func _enter_tree() -> void:
	SignalHub.update_energy_labels.connect(update_energy_labels)

func update_energy_labels(player: Player = BattleManager.player) -> void:
	energy_label.text = "%d/%d" % [player.energy.current, player.max_char_energy]
	ai_energy_label.text = "%d/%d" % [player.ai_energy.current, player.max_ai_energy]
