class_name Audio
extends Node


static var config_sample_hz := 44100.0


var play_player_choir := false
var play_target_choir := false

var player_choir: Array[Chorister] = []
var target_choir: Array[Chorister] = []


@onready var _audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var _playback: AudioStreamPlayback = _audio_stream_player.get_stream_playback()


func _ready() -> void:
	_audio_stream_player.stream.mix_rate = config_sample_hz


func _process(_delta: float) -> void:
	if play_target_choir or play_player_choir:
		_fill_buffer()


func _fill_buffer() -> void:
	
	var to_fill: int = _playback.get_frames_available()
	while to_fill > 0:
		var frame := Vector2.ONE # stereo 1:1
		if play_target_choir:
			frame = _synthesize_choir(target_choir, frame)
		if play_player_choir:
			frame = _synthesize_choir(player_choir, frame)
		_playback.push_frame(frame)
		to_fill -= 1


func _synthesize_choir(choir: Array[Chorister], frame: Vector2) -> Vector2:
	for chorister: Chorister in choir:
		frame *= chorister.synthesize()
	return frame
