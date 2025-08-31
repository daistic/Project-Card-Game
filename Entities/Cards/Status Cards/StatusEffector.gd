class_name StatusEffector

extends CardInterface

@export var is_debuff: bool = false
@export var turns: int = 0

func can_be_applied(_damageable: Damageable) -> bool:
	return true

func apply_stat_effect(_damageable: Damageable) -> void:
	#does nothing
	pass

func apply_effect() -> void:
	#does nothing
	pass

func on_appended() -> void:
	#does nothing
	pass

func on_erased() -> void:
	#do nothing
	pass
