extends Node

var ringing_player: AudioStreamPlayer
var static_player: AudioStreamPlayer
var foley_player: AudioStreamPlayer
var ui_player: AudioStreamPlayer
var text_blip_player: AudioStreamPlayer

var snd_ringing = preload("res://assets/audio/phone_ringing.wav")
var snd_static = preload("res://assets/audio/static.wav")
var snd_text_blip = preload("res://assets/audio/text_blip.ogg")

var snd_plug = preload("res://assets/audio/plug_unplug.wav")
var snd_unplug = preload("res://assets/audio/plug_unplug.wav")
var snd_relay = preload("res://assets/audio/relay_click.wav")
var snd_pickup = preload("res://assets/audio/telephone_pick_up.wav")
var snd_page = preload("res://assets/audio/page_turning.wav")

func _ready():
	ringing_player = AudioStreamPlayer.new()
	ringing_player.stream = snd_ringing
	add_child(ringing_player)
	
	static_player = AudioStreamPlayer.new()
	static_player.stream = snd_static
	add_child(static_player)
	
	text_blip_player = AudioStreamPlayer.new()
	text_blip_player.stream = snd_text_blip
	text_blip_player.max_polyphony = 1
	add_child(text_blip_player)
	
	foley_player = AudioStreamPlayer.new()
	add_child(foley_player)
	
	ui_player = AudioStreamPlayer.new()
	add_child(ui_player)


func play_ringing():
	if not ringing_player.playing: ringing_player.play()


func stop_ringing():
	ringing_player.stop()


func play_static():
	static_player.play()


func stop_static():
	static_player.stop()


func play_text_blip():
	text_blip_player.play()


func stop_text_blip():
	text_blip_player.stop()


func play_foley(sound_type: String):
	match sound_type:
		"plug": foley_player.stream = snd_plug
		"unplug": foley_player.stream = snd_unplug
		"relay": foley_player.stream = snd_relay
		"pickup": foley_player.stream = snd_pickup
	foley_player.play()


func play_ui(sound_type: String):
	if sound_type == "page":
		ui_player.stream = snd_page
		ui_player.play()
