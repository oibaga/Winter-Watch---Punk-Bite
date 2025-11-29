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
	
	player.interaction_canvas_layer.visible = true

func StopInspection():
	player.interaction_canvas_layer.visible = false
	
	player = null
	
	self.visible = false
