class_name Cadeira extends ObjetoInteragivel 

@export var SitPoint : Marker3D
@export var collisions : Array[CollisionShape3D]
@export var sitSound : AudioStreamPlayer2D

func disable_collision():
	self.set_deferred("monitorable", false)
	
	for collision in collisions:
		collision.set_deferred("disabled", true)

func pode_interagir(_player : Player) -> bool:
	return _player.itemInHand == null

func Sound():
	sitSound.play()
