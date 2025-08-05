class_name CardsResource

extends Resource

@export var data: Array[CardProperties]
@export var null_data_exception: CardProperties

func get_card_properties(index: int) -> CardProperties:
	if data[index]:
		return data[index]
	else:
		return null_data_exception
