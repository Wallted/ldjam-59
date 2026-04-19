class_name VolumeControl
extends Node2D

const SPEAKER = preload("uid://bnlebu6wxjql")
const SPEAKER_MUTED = preload("uid://c3oltv0swl6gp")
@onready var mute_button: TextureButton = $MuteButton
@onready var volume_slider: HSlider = $VolumeSlider

var is_muted: bool = false;
var volume: int = 100;

signal volume_slider_change(value)

func _ready() -> void:
	self.mute_button.pressed.connect(toggle_mute)
	self.volume_slider.value = volume
	self.volume_slider.value_changed.connect(set_volume.bind())


func toggle_mute():
	self.is_muted = !self.is_muted
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), self.is_muted)
	if self.is_muted:
		self.mute_button.texture_normal = SPEAKER_MUTED
	else:
		self.mute_button.texture_normal = SPEAKER


func set_volume(value: int) -> void:
	self.volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value/100.0))
	
	
