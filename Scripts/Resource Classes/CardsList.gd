class_name CardsList

extends Resource

@export var file_names: Array[CardsListStruct]

func add_files(sp: String, pp: String) -> void:
	if sp.ends_with(".tmp") == false:
		var cls: CardsListStruct = CardsListStruct.new()
		
		cls.scene_path = sp
		cls.properties_path = pp
		
		file_names.append(cls)
