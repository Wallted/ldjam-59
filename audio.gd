class_name Audio
extends Node


static var config_sample_hz := 22100.0


enum WhoSings{
	None,
	Target,
	Player,
}

var who_sings := WhoSings.None

var audio_stream_player_table: Array[AudioStreamPlayer] = []

@onready var _audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var level: Level

func _ready() -> void:
	_audio_stream_player.stream.mix_rate = config_sample_hz
	audio_stream_player_table = [$AudioStreamPlayer/AudioStreamPlayer1,$AudioStreamPlayer/AudioStreamPlayer2,$AudioStreamPlayer/AudioStreamPlayer3,$AudioStreamPlayer/AudioStreamPlayer4,$AudioStreamPlayer/AudioStreamPlayer5,$AudioStreamPlayer/AudioStreamPlayer6]

func _process(_delta: float) -> void:
	match who_sings:
		WhoSings.Target:
			_fill_buffer(level.target_choir)
		WhoSings.Player:
			_fill_buffer(level.player_choir)


func _fill_buffer(choir: Array[Chorister]) -> void:
	
	assert(choir.size() <= 6)
	for i in choir.size():
		var playback = audio_stream_player_table[i].get_stream_playback()
		var to_fill: int = playback.get_frames_available()
		while to_fill > 0:
			var frame := Vector2.ONE # stereo 1:1
			frame += Vector2.ONE * choir[i].synthesize()
			playback.push_frame(frame)
			to_fill -= 1
