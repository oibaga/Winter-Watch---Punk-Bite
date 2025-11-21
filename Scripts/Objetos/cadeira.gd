class_name Cadeira extends ObjetoInteragivel 

@export var SitPoint : Marker3D
@export var collisions : Array[CollisionShape3D]

func disable_collision():
	self.set_deferred("monitorable", false)
	
	for collision in collisions:
		collision.set_deferred("disabled", true)
