class_name SoundAnomaly extends Anomaly

@export var audios : Array[AudioStream]
@onready var audioPlayer: AudioStreamPlayer2D = $AudioStreamPlayer2D

func SpawnAnomaly():
	super.SpawnAnomaly()

	if !audios.is_empty():
		audioPlayer.stream = audios.pick_random()
		audioPlayer.play()

func ResolveAnomaly():
	super.ResolveAnomaly()
	
	audioPlayer.stop()
	audioPlayer.stream = null
