class_name SoundAnomaly extends Anomaly

@export var audios : Array[AudioStream]
@onready var audioPlayer: AudioStreamPlayer2D = $AudioStreamPlayer2D
var defaultVolume : float = 0

func _ready() -> void:
	defaultVolume = audioPlayer.volume_db
	HideAnomaly()

func SpawnAnomaly():
	super.SpawnAnomaly()

	if !audios.is_empty():
		audioPlayer.stream = audios.pick_random()
		audioPlayer.play()

func ResolveAnomaly():
	super.ResolveAnomaly()
	
	audioPlayer.stop()
	audioPlayer.stream = null

func ShowAnomaly():
	audioPlayer.volume_db = defaultVolume
	
func HideAnomaly():
	audioPlayer.volume_db = -80
