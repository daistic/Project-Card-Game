class_name CardInterface

extends Resource

@export var name: String = ""
@export var desc: String = ""
@export var energy_cost: int = 0
@export var ai_energy_cost: int = 0
@export var is_malware: bool = false

func get_card_damage(_damageable: Damageable) -> float:
	#does nothing
	return 0.0

func regenerate_stat(_damageable: Damageable) -> void:
	#does nothing
	pass

func degenerate_stat(_damageable: Damageable) -> void:
	#does nothing
	pass

func generate_energy(_energy: Variant, _ai_energy: Variant) -> void:
	#does nothing
	pass

func get_desc_format() -> Array:
	#does nothing
	return []

func use_card_action(_damageable: Damageable) -> void:
	return

func play_sfx() -> void:
	return
