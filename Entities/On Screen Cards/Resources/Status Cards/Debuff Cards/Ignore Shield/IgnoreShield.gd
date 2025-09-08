class_name IgnoreShield

extends StatusEffector

@export var debuff: float = 0.5

func apply_stat_effect(_damageable: Damageable) -> void:
	_damageable.cur_shield *= debuff

func get_desc_format() -> Array:
	return [debuff * 100, turns]

func play_sfx() -> void:
	SoundManager.play_modifier_sfx("Status Effect")
