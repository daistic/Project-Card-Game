class_name GameButton

extends TextureButton

var tween: Tween

func _enter_tree() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)

func _ready() -> void:
	if disabled:
		_modulate_gray()

func _on_mouse_entered() -> void:
	if disabled == false:
		_modulate_gray()

func _on_mouse_exited() -> void:
	if disabled == false:
		_reset_modulate()

func _on_pressed() -> void:
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0), 0.05)
	tween.tween_property(self, "modulate", Color(0.8, 0.8, 0.8), 0.05)
	
	SoundManager.play_sfx("Button Click")

func undisable_button() -> void:
	disabled = false
	_reset_modulate()

func disable_button() -> void:
	disabled = true
	_modulate_gray()

func _modulate_gray() -> void:
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(self, "modulate", Color(0.8, 0.8, 0.8), 0.05)

func _reset_modulate() -> void:
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0), 0.05)
