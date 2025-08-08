extends Node

const CARDS_LIST: CardsList = preload("res://Resources/Cards List/CardFileList.tres")

var cards_scene: Array[PackedScene]= []
var cards_properties: Array[CardProperties] = []

enum CARDS_TYPE{
	Basic_ATK,
	Basic_HEAL,
	Basic_SHIELD
}

func _enter_tree() -> void:
	for fn in CARDS_LIST.file_names:
		cards_scene.append(load(fn.scene_path))
		cards_properties.append(load(fn.properties_path))

func get_card_scene(type: CARDS_TYPE) -> PackedScene:
	return cards_scene[type]
