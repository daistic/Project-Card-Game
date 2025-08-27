class_name AttackBuff

extends StatusEffector

@export var buff: float = 0.15

func apply_stat_effect(_damageable: Damageable) -> void:
	_damageable.atk += _damageable.atk * buff

func get_desc_format() -> Array:
	return [buff * 100, turns]

func play_sfx() -> void:
	SoundManager.play_modifier_sfx("Status Effect")
