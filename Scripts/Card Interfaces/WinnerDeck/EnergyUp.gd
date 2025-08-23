class_name EnergyUp

extends CardInterface

@export var energy: int = 3

func generate_energy(_energy: Variant, _ai_energy: Variant) -> void:
	_energy.current += energy

func get_desc_format() -> Array:
	return [energy]

func play_sfx() -> void:
	SoundManager.play_modifier_sfx("Heal")
