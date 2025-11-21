extends Node3D

var sensitivity := 0.2
const MAX_YAW = deg_to_rad(90.0)
const MIN_YAW = deg_to_rad(-90.0)

var sitting_yaw := 0.0 # guarda a rotação Y da câmera ao sentar

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var parent_body:Player = get_parent()

		# =============================
		#      MODO SENTADO
		# =============================
		if parent_body.is_sitting:
			print(parent_body.interact_ray.global_position)
			# girar câmera para esquerda/direita (Y)
			rotation.y -= deg_to_rad(event.relative.x * sensitivity)

			# limitar rotação horizontal
			var current_yaw = wrapf(rotation.y - sitting_yaw, -PI, PI)

			if current_yaw > MAX_YAW:
				rotation.y = sitting_yaw + MAX_YAW
			elif current_yaw < MIN_YAW:
				rotation.y = sitting_yaw + MIN_YAW

			# girar vertical (X)
			rotation.x = clamp(rotation.x - deg_to_rad(event.relative.y * sensitivity),
				deg_to_rad(-90), deg_to_rad(90))

		# =============================
		#      MODO NORMAL (em pé)
		# =============================
		else:
			print(parent_body.interact_ray.global_position)
			# corpo gira esquerda/direita
			parent_body.rotate_y(deg_to_rad(-event.relative.x * sensitivity))

			# câmera gira pra cima/baixo
			rotation.x = clamp(rotation.x - deg_to_rad(event.relative.y * sensitivity),
				deg_to_rad(-90), deg_to_rad(90))
