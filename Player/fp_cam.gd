extends Node3D

var sensitivy = 0.2
const MAX_YAW = deg_to_rad(90.0)
const MIN_YAW = deg_to_rad(-90.0)

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var parent_body = get_parent()

		if parent_body.is_sitting:
			
			var delta_yaw = deg_to_rad(-event.relative.x * sensitivy)
			parent_body.rotate_y(delta_yaw)
			
			var current_yaw = wrapf(parent_body.rotation.y - parent_body.sitting_base_yaw, -PI, PI)
			
			if current_yaw > MAX_YAW:
				parent_body.rotation.y = parent_body.sitting_base_yaw + MAX_YAW
			elif current_yaw < MIN_YAW:
				parent_body.rotation.y = parent_body.sitting_base_yaw + MIN_YAW
				
			rotate_x(deg_to_rad(-event.relative.y * sensitivy))

		else:
			parent_body.rotate_y(deg_to_rad(-event.relative.x * sensitivy))
			rotate_x(deg_to_rad(-event.relative.y * sensitivy))

		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))
