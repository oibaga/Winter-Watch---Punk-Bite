class_name ManualFechado extends ObjetoInteragivel

@export var manualAberto : ManualAberto

func _ready() -> void:
	manualAberto.visible = false
	super._ready()

func pode_interagir(_player : Player) -> bool:
	return _player.sitting_on_node == null

func interagir(_player : Player):
	_player.objeto_inspecionado = manualAberto
