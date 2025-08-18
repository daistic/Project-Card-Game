class_name StatusEffectUI

extends TextureRect

@onready var information: TextureRect = $Information
@onready var desc_label: RichTextLabel = $Information/DescLabel

var is_enemy_status_effect: bool = false
var information_default_pos: Vector2 = Vector2.ZERO
var status_effect: StatusEffector
var desc: String = ""

func setup_ui(_texture: CompressedTexture2D, _status_effect: StatusEffector, 
		_is_enemy_status_effect: bool) -> void:
	texture = _texture
	status_effect = _status_effect
	is_enemy_status_effect = _is_enemy_status_effect
	update_desc()

func _ready() -> void:
	information_default_pos = information.position

func update_desc() -> void:
	desc = status_effect.desc % status_effect.get_desc_format()

func _on_mouse_entered() -> void:
	var viewport_size: Vector2 = get_viewport_rect().size
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	var offset: Vector2 = Vector2.ZERO
	
	if mouse_pos.y < viewport_size.y / 2:
		offset = Vector2(0, information.size.y / 2)
	else:
		offset = Vector2(0, -(information.size.y / 2))
	
	information.position = information_default_pos + offset
	desc_label.text = desc
	information.show()

func _on_mouse_exited() -> void:
	information.position = information_default_pos
	information.hide()
