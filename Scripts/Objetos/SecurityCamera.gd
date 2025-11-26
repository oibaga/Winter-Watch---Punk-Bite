class_name SecurityCamera extends SubViewport

@onready var camera_3d: Camera3D = $Camera3D
@onready var color_rect: ColorRect = $Control/ShaderColorRect
@onready var room: Room = $".."
@export var animationPlayer : AnimationPlayer
