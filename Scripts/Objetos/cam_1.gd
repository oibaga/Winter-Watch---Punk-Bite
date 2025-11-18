extends Node

@onready var LabelCAM: Label = $CanvasLayer/LabelCAM
@onready var LabelClock: Label = $CanvasLayer/LabelClock

@export var camera_id: int = 1

func _ready():
	LabelCAM.text = "CAM_" + str(camera_id)
	print("Label_CAM:", $CanvasLayer/LabelCAM)
	print("Label_Hora:", $CanvasLayer/LabelClock)


func _process(delta):
	var t = Time.get_datetime_dict_from_system()
	LabelClock.text = "%02d:%02d:%02d" % [t.hour, t.minute, t.second]
