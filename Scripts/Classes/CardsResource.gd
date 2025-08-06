class_name CardsResource

extends Resource

@export var scenes: Array[PackedScene]
@export var null_data_exception: PackedScene

func get_card_properties(index: int) -> PackedScene:
	if scenes[index]:
		return scenes[index]
	else:
		return null_data_exception
