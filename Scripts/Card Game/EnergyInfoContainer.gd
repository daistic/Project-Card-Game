extends VBoxContainer

@onready var energy_label: Label = $EnergyTexture/EnergyLabel
@onready var ai_energy_label: Label = $AIEnergyTexture/AIEnergyLabel

func _enter_tree() -> void:
	SignalHub.player_ready.connect(_on_player_ready)
	SignalHub.player_finished_calculations.connect(_on_player_finished_calculations)

func _on_player_ready() -> void:
	_on_player_finished_calculations()

func _on_player_finished_calculations() -> void:
	var player: Player = BattleManager.player
	energy_label.text = "%d/%d" % [player.cur_energy, player.max_char_energy]
	ai_energy_label.text = "%d/%d" % [player.cur_ai_energy, player.max_ai_energy]
