class_name AIEnergyUp

extends CardInterface

@export var energy_up: float = 2.0

func generate_energy(_energy: Variant, _ai_energy: Variant) -> void:
	_ai_energy.current += energy_up

func get_desc_format() -> Array:
	return [energy_up]

func play_sfx() -> void:
	SoundManager.play_modifier_sfx("Heal")
