extends Anomaly

@export var anomalies : Array[Node3D]
var currentAnomaly : Node3D
@export var doorToOpen : PortaAbrivel

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

func ShowAnomaly(_painelTV : PainelTV):
	if (currentAnomaly): 
		currentAnomaly.visible = true

		_painelTV.anomalyDefaultSound.play()

		if doorToOpen:
			if not doorToOpen.aberta:
				doorToOpen.TrocarEstado()

func HideAnomaly():
	if (currentAnomaly): 
		currentAnomaly.visible = false
		
		if doorToOpen:
			if doorToOpen.aberta:
				doorToOpen.TrocarEstado()
