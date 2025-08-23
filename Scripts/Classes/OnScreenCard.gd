class_name OnScreenCard

extends TextureRect

@onready var shadow: TextureRect = $Shadow
@onready var energy_cost_bar: TextureProgressBar = $EnergyCostBar
@onready var frame: TextureRect = $Frame
@onready var title_label: Label = $TitleLabel
@onready var desc_label: RichTextLabel = $DescLabel
@onready var sfx_player: AudioStreamPlayer = $SFXPlayer

@export var card_resource: CardInterface
@export var on_hover_sfx: AudioStream
@export var cant_use_sfx: AudioStream

static var card_being_dragged: OnScreenCard = null

var last_mouse_pos: Vector2
var mouse_velocity: Vector2
var preview_card: OnScreenCard

const NORMAL_SIZE: Vector2 = Vector2(1.0, 1.0)
const SCALE_SIZE: Vector2 = Vector2(1.4, 1.4)
const SCALE_TIME: float = 0.15
const MOUSE_ENTERING: bool = true
const MAX_SHADOW_OFFSET: float = 20.0

func _input(event: InputEvent) -> void:
	if event.is_action_released("Mouse Click") and not visible:
		self.show()

func _enter_tree() -> void:
	SignalHub.card_used.connect(_on_card_used)

func _ready() -> void:
	if card_resource == null:
		queue_free()
	
	_setup_childrens()

func _process(_delta: float) -> void:
	_handle_preview_rotation(_delta)
	_handle_shadow()

func _handle_preview_rotation(delta: float) -> void:
	if card_being_dragged and preview_card:
		var mouse_pos = get_viewport().get_mouse_position()
		mouse_velocity = (mouse_pos - last_mouse_pos) / delta
		last_mouse_pos = mouse_pos
		
		var target_rot: float = clamp(mouse_velocity.x * 0.002, -0.3, 0.3)
		preview_card.rotation = lerp(preview_card.rotation, target_rot, delta * 8.0)

func _handle_shadow() -> void:
	var center: Vector2 = get_viewport_rect().size / 2.0
	var distance: float = global_position.x - center.x
	
	shadow.position.x = lerp(0.0, -sign(distance) * MAX_SHADOW_OFFSET, abs(distance/(center.x)))

func _get_drag_data(_at_position: Vector2) -> Variant:
	preview_card = self.duplicate()
	preview_card.scale *= SCALE_SIZE
	
	var preview = Control.new()
	preview.z_index = 1
	preview.add_child(preview_card)
	set_drag_preview(preview)
	
	card_being_dragged = self
	hide()
	
	return self

func _tween_scale_animation(is_mouse_entering: bool) -> void:
	var tween: Tween = create_tween()
	
	if is_mouse_entering:
		z_index += 1
		tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(self, "scale", SCALE_SIZE, SCALE_TIME)
	else:
		z_index -= 1
		tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(self, "scale", NORMAL_SIZE, SCALE_TIME)

func _on_card_used(_resource: CardInterface) -> void:
	if card_being_dragged == self and card_being_dragged != null:
		card_being_dragged.queue_free()

func _setup_childrens() -> void:
	title_label.text = card_resource.name
	desc_label.text = card_resource.desc % card_resource.get_desc_format()
	
	if card_resource.ai_energy_cost > 0:
		energy_cost_bar.value = card_resource.ai_energy_cost
	else:
		energy_cost_bar.value = card_resource.energy_cost

func play_on_hover_sfx() -> void:
	sfx_player.stop()
	sfx_player.volume_db = SoundManager.get_sfx_volume()
	sfx_player.stream = on_hover_sfx
	sfx_player.play()

func play_cant_use_sfx() -> void:
	sfx_player.stop()
	sfx_player.volume_db = SoundManager.get_sfx_volume()
	sfx_player.stream = cant_use_sfx
	sfx_player.play()

func _on_mouse_entered() -> void:
	_tween_scale_animation(MOUSE_ENTERING)
	play_on_hover_sfx()

func _on_mouse_exited() -> void:
	_tween_scale_animation(not MOUSE_ENTERING)
