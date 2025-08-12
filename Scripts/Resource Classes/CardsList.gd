class_name CardsList

extends Resource

@export var file_names: Array[CardsListStruct]

func add_files(sp: String, crp: String) -> void:
	if sp.ends_with(".tmp") == false:
		var cls: CardsListStruct = CardsListStruct.new()
		
		cls.scene_path = sp
		cls.card_resource_path= crp
		
		file_names.append(cls)

@export var starting_deck_scenes: Array[PackedScene]
