class_name ButtonFromMenu extends ObjetoInteragivel

@export var anomalyTargetType : Anomaly.AnomalyTypes
@export var painelTV : PainelTV
@onready var buttonMesh: MeshInstance3D = $Botão
@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer3D

func pode_interagir(_player : Player) -> bool:
	return _player.sitting_on_node != null && painelTV.canChose && painelTV.currentCamera

func interagir(_player : Player):
	painelTV.ChoseAnomalyType(anomalyTargetType)
	
	audio.play()
	buttonMesh.position.x = -0.005
	await get_tree().create_timer(0.25).timeout
	buttonMesh.position.x = 0.0
