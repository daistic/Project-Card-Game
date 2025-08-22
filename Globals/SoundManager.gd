extends Node

const BGM_MAP: Dictionary[String, AudioStream] = {
	"Menu": preload("res://Assets/Audio/BGM/Main Menu maybe. _DavidKBD - Code injection Pack - 01 - Underbeat.ogg"),
	"Battle": preload("res://Assets/Audio/BGM/Battlescene.mp3")
}

const SFX_MAP: Dictionary[String, AudioStream] = {
	
}

var bgm_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

func _ready() -> void:
	bgm_player = AudioStreamPlayer.new()
	add_child(bgm_player)
	
	sfx_player = AudioStreamPlayer.new()
	add_child(sfx_player)

func play_bgm(bgm: String) -> void:
	if !BGM_MAP.has(bgm):
		return
	
	if bgm_player.stream == BGM_MAP[bgm]:
		return
	
	bgm_player.stop()
	bgm_player.stream  = BGM_MAP[bgm]
	bgm_player.play()

func disable_bgm() -> void:
	bgm_player.stop()

func play_sfx(sfx: String) -> void:
	if !SFX_MAP.has(sfx):
		return
	
	if sfx_player.stream == SFX_MAP[sfx]:
		return
	
	sfx_player.stop()
	sfx_player.stream  = sfx_player[sfx]
	sfx_player.play()

func play_sound(player: AudioStreamPlayer, audio: AudioStream) -> void:
	player.stop()
	player.stream = audio
	player.play()
