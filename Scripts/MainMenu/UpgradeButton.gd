class_name UpgradeButton extends Node
@export var stat_type=0
var upgrade_cost=10
var downgrade_cost=10
@export var logo:TextureRect
@export var Text:Texture2D
@export var Value:Label
@export var UpCost:Label
@export var DownCost:Label
func _ready() -> void:
	logo.texture=Text
	to_reset()
func to_reset():
	Value.text=str(MenuHub.stat[stat_type])
	UpCost.text=str(upgrade_cost)
	DownCost.text=str(downgrade_cost)
	
	
