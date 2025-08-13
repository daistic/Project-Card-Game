extends TextureButton

@onready var grey_hover: GreyHover = $GreyHover

func _on_mouse_entered() -> void:
	modulate = grey_hover.color_on_hover()

func _on_mouse_exited() -> void:
	modulate = grey_hover.color_on_normal()
