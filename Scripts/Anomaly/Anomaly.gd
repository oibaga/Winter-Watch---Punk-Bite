class_name Anomaly extends Node3D

@export var type : AnomalyTypes = AnomalyTypes.CreatureType
@onready var lifeTimer : Timer = $"../AnomalyTimer"
@export var duration : float = 60.0
@export var room : Room

enum AnomalyTypes {CreatureType, SoundType, VisualType, GlitchType, GeigerType, CopyType}

func SpawnAnomaly():
	if room.anomalyReference != self: return

	lifeTimer.start( duration )

func ResolveAnomaly():
	if room.anomalyReference != self: return

	room.AnomalyResolved()

	lifeTimer.stop()

func ShowAnomaly(_painelTV : PainelTV):
	pass

func HideAnomaly():
	pass
