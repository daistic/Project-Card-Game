extends TextureRect

@onready var cards_container: HBoxContainer = $Parallax/Screen/MarginContainer/MarginContainer2/CardsContainer
@onready var next_battle_button: TextureButton = $Parallax/Screen/NextBattleButton
@onready var story_label: RichTextLabel = $Parallax/Screen/MarginContainer/VBoxContainer/StoryLabel
@onready var parallax: Control = $Parallax
@onready var fade: ColorRect = $PostProcessing/Fade
@onready var fade_animation: AnimationPlayer = $PostProcessing/Fade/FadeAnimation

@export var max_parallax_offset: Vector2 = Vector2(2.5, 2.5)
@export var smoothing: float = 5.0

func _enter_tree() -> void:
	SignalHub.card_selected.connect(_on_card_selected)

func _ready() -> void:
	for scene in Global.get_3_random_winner_cards():
		var instance: OnScreenCard = scene.instantiate()
		cards_container.add_child(instance)
	
	story_label.text = BattleManager.get_formatted_story_message()

func _process(delta: float) -> void:
	_handle_parallax_effect(delta)

func _handle_parallax_effect(delta: float) -> void:
	var center: Vector2 = get_viewport_rect().size / 2.0
	var dist: Vector2 = get_global_mouse_position() - center
	var offset: Vector2 = dist / center
	
	var new_pos: Vector2
	
	new_pos.x = lerp(max_parallax_offset.x, -max_parallax_offset.x, offset.x)
	new_pos.y = lerp(max_parallax_offset.y, -max_parallax_offset.y, offset.y)
	
	parallax.position.x = lerp(parallax.position.x, new_pos.x, smoothing * delta)
	parallax.position.y = lerp(parallax.position.y, new_pos.y, smoothing * delta) 

func _on_card_selected() -> void:
	for card in cards_container.get_children():
		card.queue_free()
	
	next_battle_button.disabled = false

func _on_texture_button_pressed() -> void:
	next_battle_button.disabled = true
	
	if BattleManager.story_index < BattleManager.CYBER_STORY.story.size():
		BattleManager.handle_next_game_scene()
	else:
		fade.show()
		fade_animation.play("Fade")
		await fade_animation.animation_finished
		Global.go_to_epilogue()
