class_name AttackTakeDamage

extends CardInterface

@export var hp_cost: float = 20
@export var damage: float = 6.5

func get_card_damage(_damageable: Damageable) -> float:
	return damage

func regenerate_stat(_damageable: Damageable) -> void:
	_damageable.cur_hp -= ((_damageable.cur_hp) * hp_cost) / 100.0
	_damageable.cur_hp = clampf(_damageable.cur_hp, 0.0, _damageable.max_hp)

func get_desc_format() -> Array:
	return [hp_cost, damage]

func play_sfx() -> void:
	SoundManager.play_modifier_sfx("Enemy Attack")
