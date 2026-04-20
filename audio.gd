class_name Audio
extends Node


static var config_sample_hz := 22100.0


enum WhoSings{
	None,
	Target,
	Player,
	Solo,
}

var who_sings := WhoSings.None

var audio_stream_player_table: Array[AudioStreamPlayer] = []

@onready var _audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var level: Level

var _solo_chorister: Array[Chorister] = [] # up to a length of one xD


func _ready() -> void:
	_audio_stream_player.stream.mix_rate = config_sample_hz
	audio_stream_player_table = [$AudioStreamPlayer/AudioStreamPlayer1,$AudioStreamPlayer/AudioStreamPlayer2,$AudioStreamPlayer/AudioStreamPlayer3,$AudioStreamPlayer/AudioStreamPlayer4,$AudioStreamPlayer/AudioStreamPlayer5,$AudioStreamPlayer/AudioStreamPlayer6]
	for i in audio_stream_player_table.size():
		audio_stream_player_table[i].stream.mix_rate = config_sample_hz
		Species.ChoristerAudioStreamPlayer[i] = audio_stream_player_table[i]

func _process(_delta: float) -> void:
	match who_sings:
		WhoSings.Target:
			_fill_buffer(level.target_choir)
		WhoSings.Player:
			_fill_buffer(level.player_choir)
		WhoSings.Solo:
			_fill_buffer(_solo_chorister)


func set_solo_chorister(index: int):
	_solo_chorister = [level.player_choir[index]]


func _fill_buffer(choir: Array[Chorister]) -> void:
	
	assert(choir.size() <= 6)
	for chorister: Chorister in choir:
		var grid_freq := 440.0 * pow(2.0,((chorister.grid_position.x - 6.0)/12.0))
		chorister.change_freq(grid_freq)
		var playback = Species.ChoristerAudioStreamPlayer[chorister.species_id].get_stream_playback()
		var to_fill: int = playback.get_frames_available()
		while to_fill > 0:
			var frame := Vector2.ONE # stereo 1:1
			frame += Vector2.ONE * chorister.synthesize()
			playback.push_frame(frame)
			to_fill -= 1
