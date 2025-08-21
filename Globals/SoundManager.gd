extends Node

var bgm_player: AudioStreamPlayer

func _ready() -> void:
	bgm_player = AudioStreamPlayer.new()
	add_child(bgm_player)

func play_bgm(bgm: AudioStream) -> void:
	if bgm_player.stream == bgm:
		return
	
	bgm_player.stop()
	bgm_player.stream  = bgm
	bgm_player.play()

func play_sound(player: AudioStreamPlayer, audio: AudioStream) -> void:
	player.stop()
	player.stream = audio
	player.play()
