extends Node

const BGM_MAP: Dictionary[String, AudioStream] = {
	"Menu": preload("res://Assets/Audio/BGM/Main Menu maybe. _DavidKBD - Code injection Pack - 01 - Underbeat.ogg"),
	"Battle": preload("res://Assets/Audio/BGM/Battlescene music new.mp3")
}

const SFX_ATTACK_MAP: Dictionary[String, AudioStream] = {
	
}

const SFX_MODIFIER_MAP: Dictionary[String, AudioStream] = {
	"Status Effect": preload("res://Assets/Audio/SFX/Buff and debuff.mp3"),
}

var bgm_player: AudioStreamPlayer
var sfx_attack_player: AudioStreamPlayer
var sfx_modifier_player: AudioStreamPlayer

func _ready() -> void:
	bgm_player = AudioStreamPlayer.new()
	add_child(bgm_player)
	
	sfx_attack_player = AudioStreamPlayer.new()
	add_child(sfx_attack_player)
	
	sfx_modifier_player = AudioStreamPlayer.new()
	add_child(sfx_modifier_player)

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

func play_attack_sfx(sfx: String) -> void:
	if !SFX_ATTACK_MAP.has(sfx):
		return
	
	if sfx_attack_player.stream == SFX_ATTACK_MAP[sfx]:
		return
	
	sfx_attack_player.stop()
	sfx_attack_player.stream  = SFX_ATTACK_MAP[sfx]
	sfx_attack_player.play()

func play_modifier_sfx(sfx: String) -> void:
	if !SFX_MODIFIER_MAP.has(sfx):
		return
	
	if sfx_modifier_player.stream == SFX_MODIFIER_MAP[sfx]:
		return
	
	sfx_modifier_player.stop()
	sfx_modifier_player.stream  = SFX_MODIFIER_MAP[sfx]
	sfx_modifier_player.play()

func play_sound(player: AudioStreamPlayer, audio: AudioStream) -> void:
	player.stop()
	player.stream = audio
	player.play()
