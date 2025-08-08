@tool
extends EditorScript

const CARDS_SCENES_FOLDER: String = "res://Scenes/On Screen Cards/"
const RESOURCE_PATH: String = "res://Resources/Cards List/CardFileList.tres"

func _run() -> void:
	var dir: DirAccess = DirAccess.open(CARDS_SCENES_FOLDER)
	var cl: CardsList = CardsList.new()
	
	if dir:
		var files: PackedStringArray = dir.get_files()
		
		for fn in files:
			if fn.ends_with(".tmp") == false:
				var scene: PackedScene = load(CARDS_SCENES_FOLDER + fn)
				var instance: OnScreenCard = scene.instantiate()
				var properties_path: String = instance.properties.resource_path
				
				cl.add_files(CARDS_SCENES_FOLDER + fn, properties_path)
	
	ResourceSaver.save(cl, RESOURCE_PATH)
