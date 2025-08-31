extends Control

@onready var parallax: Control = $Parallax
@onready var start: GameButton = $Start
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	SoundManager.disable_bgm()
	audio_stream_player.volume_db = SoundManager.sfx_volume

func _on_start_pressed() -> void:
	BattleManager.go_to_card_game()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	start.show()
