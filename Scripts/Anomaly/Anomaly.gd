class_name Anomaly extends Node3D

@export var type : AnomalyTypes = AnomalyTypes.CreatureType
@onready var lifeTimer : Timer = $"../AnomalyTimer"
@export var duration : float = 60.0
var room : Room

enum AnomalyTypes {CreatureType, SoundType, VisualType, GlitchType, GeigerType, CopyType}

func _ready() -> void:
	room = get_parent() as Room

func SpawnAnomaly():
	lifeTimer.start( duration )

func ResolveAnomaly():
	room.AnomalyResolved()
	
	lifeTimer.stop()
