class_name ButtonFromMenu extends ObjetoInteragivel

func pode_interagir(_player : Player) -> bool:
	return _player.sitting_on_node != null
