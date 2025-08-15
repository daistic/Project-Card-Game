extends VBoxContainer

@onready var energy_label: Label = $EnergyTexture/EnergyLabel
@onready var ai_energy_label: Label = $AIEnergyTexture/AIEnergyLabel

func _ready() -> void:
	SignalHub.player_ready.connect(_on_player_ready)
	SignalHub.update_energy_labels.connect(_on_update_energy_labels)
	
	if BattleManager.player != null:
		_on_player_ready()

func _on_player_ready() -> void:
	_on_update_energy_labels()

func _on_update_energy_labels() -> void:
	var player: Player = BattleManager.player
	energy_label.text = "%d/%d" % [player.cur_energy, player.max_char_energy]
	ai_energy_label.text = "%d/%d" % [player.cur_ai_energy, player.max_ai_energy]
