extends ObjetoInteragivel

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

var aberta : bool = false

func pode_interagir(_player : Player) -> bool:
	return !animation_player.is_playing()

func interagir(_player : Player):
	aberta = not aberta

	if (aberta):
		hint_label.text = "Close"
		animation_player.play("Open")
	else:
		hint_label.text = "Open"
		animation_player.play("Close")
