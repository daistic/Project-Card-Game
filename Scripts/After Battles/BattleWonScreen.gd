extends TextureRect

@onready var cards_container: HBoxContainer = $Screen/MarginContainer/MarginContainer2/CardsContainer
@onready var next_battle_button: TextureButton = $Screen/NextBattleButton
@onready var story_label: RichTextLabel = $Screen/MarginContainer/VBoxContainer/StoryLabel

func _enter_tree() -> void:
	SignalHub.card_selected.connect(_on_card_selected)

func _ready() -> void:
	for scene in Global.get_3_random_winner_cards():
		var instance: OnScreenCard = scene.instantiate()
		cards_container.add_child(instance)
	
	story_label.text = BattleManager.get_formatted_story_message()

func _on_card_selected() -> void:
	for card in cards_container.get_children():
		card.queue_free()
	
	next_battle_button.disabled = false

func _on_texture_button_pressed() -> void:
	next_battle_button.disabled = true
	BattleManager.go_to_card_game()
