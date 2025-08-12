class_name CardInterface

extends Resource

@export var name: String = ""
@export var desc: String = ""
@export var energy_cost: int = 0
@export var ai_energy_cost: int = 0

func get_card_damage() -> float:
	#does nothing
	return 0.0

func regenerate_stat(_damageable: Damageable) -> void:
	#does nothing
	pass

func get_desc_format() -> Array:
	#does nothing
	return []
