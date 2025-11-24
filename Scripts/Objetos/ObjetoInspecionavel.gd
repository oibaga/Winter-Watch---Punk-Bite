class_name ObjetoInspecionavel extends Node3D

var player : Player = null

# DEVEM SER SOBRESCRITAS NAS FILHAS
func LeftPressed():
	pass
	
func RightPressed():
	pass
	
	# DEVEM SER CHAMADAS POR PLAYER
func StartInspection(_player : Player):
	player = _player
	
	self.visible = true

func StopInspection():
	player = null
	
	self.visible = false
