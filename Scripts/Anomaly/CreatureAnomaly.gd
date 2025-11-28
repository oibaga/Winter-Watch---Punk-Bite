extends Anomaly

@export var anomalies : Array[Node3D]
var currentAnomaly : Node3D

func _ready() -> void:
	for anomaly in anomalies:
		anomaly.visible = false

func SpawnAnomaly():
	super.SpawnAnomaly()

	currentAnomaly = anomalies.pick_random()

func ResolveAnomaly():
	super.ResolveAnomaly()

	currentAnomaly.visible = false
	currentAnomaly = null

func ShowAnomaly():
	if (currentAnomaly): currentAnomaly.visible = true

func HideAnomaly():
	if (currentAnomaly): currentAnomaly.visible = false
