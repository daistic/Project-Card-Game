extends Node

const BGM_MAP: Dictionary[String, AudioStream] = {
	"Menu": preload("res://Assets/Audio/BGM/Main Menu maybe. _DavidKBD - Code injection Pack - 01 - Underbeat.ogg"),
	"Battle": preload("res://Assets/Audio/BGM/Battlescene music new plus.mp3")
}

const SFX_MAP: Dictionary[String, AudioStream] = {
	"Status Effect" : preload("res://Assets/Audio/SFX/Buff and debuff.mp3"),
	"Enemy Attack": preload("res://Assets/Audio/SFX/Enemy atk.mp3"),
	"Player Attack": preload("res://Assets/Audio/SFX/Player Hit.mp3"),
	"Shuffle": preload("res://Assets/Audio/SFX/Shuffle card.mp3"),
	"Shield": preload("res://Assets/Audio/SFX/Shield.mp3"),
	"Button Click": preload("res://Assets/Audio/SFX/SFX Tombol baru yg ini.mp3"),
	"Pause": preload("res://Assets/Audio/SFX/Pause.mp3"),
	"Heal": preload("res://Assets/Audio/SFX/Healing.mp3"),
	"Crit": preload("res://Assets/Audio/SFX/Crit atk.mp3"),
	"Morimens": preload("res://Assets/Audio/SFX/data-sfx-367521.mp3"),
	"Shield Break": preload("res://Assets/Audio/SFX/Shield Break.mp3")
}

const SAVE_PATH: String = "user://save_data.tres"

var bgm_player: AudioStreamPlayer
var sfx_attack_player: AudioStreamPlayer
var sfx_modifier_player: AudioStreamPlayer
var sfx_general_player: AudioStreamPlayer

var bgm_volume: float
var sfx_volume: float

func _ready() -> void:
	bgm_player = AudioStreamPlayer.new()
	add_child(bgm_player)
	
	sfx_attack_player = AudioStreamPlayer.new()
	add_child(sfx_attack_player)
	
	sfx_modifier_player = AudioStreamPlayer.new()
	add_child(sfx_modifier_player)
	
	sfx_general_player = AudioStreamPlayer.new()
	add_child(sfx_general_player)
	
	load_player_settings()

func load_player_settings() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		var data: SaveData = ResourceLoader.load(SAVE_PATH)
		bgm_volume = data.bgm_volume
		sfx_volume = data.sfx_volume

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
	if !SFX_MAP.has(sfx):
		return
	
	sfx_attack_player.stop()
	sfx_attack_player.stream  = SFX_MAP[sfx]
	sfx_attack_player.play()

func play_modifier_sfx(sfx: String) -> void:
	if !SFX_MAP.has(sfx):
		return
	
	sfx_modifier_player.stop()
	sfx_modifier_player.stream  = SFX_MAP[sfx]
	sfx_modifier_player.play()

func play_sfx(sfx: String) -> void:
	if !SFX_MAP.has(sfx):
		return
	
	sfx_general_player.stop()
	sfx_general_player.stream  = SFX_MAP[sfx]
	sfx_general_player.play()

func play_sound(player: AudioStreamPlayer, audio: AudioStream) -> void:
	player.stop()
	player.stream = audio
	player.play()

func set_bgm_volume(value: float) -> void:
	bgm_player.volume_db = value
	bgm_volume = value

func set_sfx_volume(value: float) -> void:
	sfx_attack_player.volume_db = value
	sfx_modifier_player.volume_db = value
	sfx_general_player.volume_db = value
	sfx_volume = value

func get_sfx_volume() -> float:
	return sfx_volume
