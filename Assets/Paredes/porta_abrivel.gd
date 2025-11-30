class_name PortaAbrivel extends ObjetoInteragivel

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@export var audioAbre : AudioStreamPlayer3D
@export var audioFecha : AudioStreamPlayer3D
var aberta : bool = false

func pode_interagir(_player : Player) -> bool:
	return !animation_player.is_playing()

func interagir(_player : Player):
	TrocarEstado()

func TrocarEstado():
	if animation_player.is_playing(): return
	
	aberta = not aberta

	if (aberta):
		Abrir()
	else:
		Fechar()

func Abrir():
	hint_label.text = "Close"
	audioAbre.play()
	audioFecha.stop()
	animation_player.play("Open")
	
func Fechar():
	hint_label.text = "Open"
	audioFecha.play()
	audioAbre.stop()
	animation_player.play("Close")
