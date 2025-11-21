extends ObjetoInteragivel

@export var painel_tv : PainelTV  # arraste o nó do painel (que tem o script de câmeras)
@export var cadeira_exigida : Cadeira

func interagir():
	if painel_tv: painel_tv.trocar_camera()

func pode_interagir(_player : Player) -> bool:
	return _player.sitting_on_node == cadeira_exigida
