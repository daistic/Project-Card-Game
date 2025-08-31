class_name CritRateBuff

extends StatusEffector

@export var buff: float

func apply_stat_effect(_damageable: Damageable) -> void:
	_damageable.crit_rate += buff

func get_desc_format() -> Array:
	return [buff * 100, turns]

func play_sfx() -> void:
	SoundManager.play_modifier_sfx("Status Effect")
