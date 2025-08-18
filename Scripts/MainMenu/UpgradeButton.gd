class_name UpgradeButton extends Node
var stat_type=0
var upgrade_cost=10
var downgrade_cost=10
@export var logo:TextureRect
@export var Text:Texture2D
func _ready() -> void:
	logo.texture=Text
