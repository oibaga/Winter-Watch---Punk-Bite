extends ObjetoInteragivel

@export var painel_tv : PainelTV  # arraste o nó do painel (que tem o script de câmeras)
@export var cadeira_exigida : Cadeira
@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer3D

func interagir(_player : Player):
	if painel_tv: 
		painel_tv.trocar_camera()
		audio.play()

func pode_interagir(_player : Player) -> bool:
	return _player.sitting_on_node != null
