class_name AttackDebuff

extends StatusEffector

@export var debuff: float = 2.5

func apply_stat_effect(_damageable: Damageable) -> void:
	_damageable.atk -= debuff

func get_desc_format() -> Array:
	return[debuff, turns]

func play_sfx() -> void:
	SoundManager.play_modifier_sfx("Status Effect")
