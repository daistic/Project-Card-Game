extends Control

@onready var parallax: Control = $Parallax
@onready var main: GameButton = $Main
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@export var max_parallax_offset: Vector2 = Vector2(2.5, 2.5)
@export var smoothing: float = 5

func _ready() -> void:
	SoundManager.disable_bgm()
	audio_stream_player.volume_db = SoundManager.sfx_volume

func _on_main_pressed() -> void:
	Global.go_to_main_menu()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	main.show()
