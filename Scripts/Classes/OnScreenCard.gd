class_name OnScreenCard

extends TextureRect

@onready var title_label: Label = $TitleLabel
@onready var desc_label: RichTextLabel = $DescLabel

@export var card_resource: CardInterface

static var card_being_dragged: OnScreenCard = null

const NORMAL_SIZE: Vector2 = Vector2(1.0, 1.0)
const SCALE_SIZE: Vector2 = Vector2(1.25, 1.25)
const SCALE_TIME: float = 0.15
const MOUSE_ENTERING: bool = true

func _input(event: InputEvent) -> void:
	if event.is_action_released("Mouse Click") and not visible:
		self.show()

func _enter_tree() -> void:
	SignalHub.card_used.connect(_on_card_used)

func _ready() -> void:
	if card_resource == null:
		queue_free()
	
	_setup_labels()

func _get_drag_data(_at_position: Vector2) -> Variant:
	var preview_scene: PackedScene = load(self.scene_file_path)
	var preview_card: OnScreenCard = preview_scene.instantiate()
	preview_card.size *= SCALE_SIZE
	
	var preview = Control.new()
	preview.add_child(preview_card)
	set_drag_preview(preview)
	
	card_being_dragged = self
	hide()
	
	return card_resource

func _tween_scale_animation(is_mouse_entering: bool) -> void:
	var tween: Tween = create_tween()
	
	if is_mouse_entering:
		tween.tween_property(self, "scale", SCALE_SIZE, SCALE_TIME)
	else:
		tween.tween_property(self, "scale", NORMAL_SIZE, SCALE_TIME)

func _on_card_used(_resource: CardInterface) -> void:
	if card_being_dragged == self and card_being_dragged != null:
		card_being_dragged.queue_free()

func _setup_labels() -> void:
	title_label.text = card_resource.name
	desc_label.text = card_resource.desc % card_resource.get_desc_format()

func _on_mouse_entered() -> void:
	_tween_scale_animation(MOUSE_ENTERING)

func _on_mouse_exited() -> void:
	_tween_scale_animation(not MOUSE_ENTERING)
