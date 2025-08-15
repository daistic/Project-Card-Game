extends Node

const CARDS_LIST: CardsList = preload("res://Resources/Cards List/CardFileList.tres")

var cards_scene: Array[PackedScene]= []
var cards_resources: Array[CardInterface] = []

enum CARDS_TYPE{
	Basic_ATK,
	Basic_HEAL,
	Basic_SHIELD
}

func _enter_tree() -> void:
	pass
	#for fn in CARDS_LIST.file_names:
		#cards_scene.append(load(fn.scene_path))
		#cards_resources.append(load(fn.card_resource_path))
