class_name GeigerSupport extends ObjetoInteragivel

@export var room : Room

func pode_interagir(_player : Player) -> bool:
	if _player.itemInHand:
		if _player.itemInHand is Geiger && room.isGeigerRoom:
			return true
	return false

func interagir(_player : Player):
	if !_player.itemInHand is Geiger:
		return

	var geiger = _player.itemInHand
	
	geiger.position = Vector3.ZERO
	geiger.rotation = Vector3.ZERO
	geiger.scale = Vector3.ONE

	add_child( geiger.duplicate() )

	_player.itemInHand.call_deferred("queue_free")
	_player.VisibleRightArm(true)
