extends Node3D

@export var player : Player
@export var camera : Camera3D

var sensitivity := 0.2
const MAX_YAW = deg_to_rad(60.0)
const MIN_YAW = deg_to_rad(-60.0)

var sitting_yaw := 0.0 # guarda a rotação Y da câmera ao sentar

var bob_time := 0.0
var base_cam_pos := Vector3(0,0,0)

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(delta):
	var horizontal_speed = Vector2(player.velocity.x, player.velocity.z).length()
	var is_moving = horizontal_speed > 0.1

	var bob_speed : float
	var bob_amount_pos : float   # amplitude do movimento da posição
	var bob_amount_rot : float   # amplitude da rotação X

	if player.is_running:
		# Forte (correndo)
		bob_speed = 13.0
		bob_amount_pos = 0.07
		bob_amount_rot = 2.2
	elif is_moving:
		# Médio (andando)
		bob_speed = 8.0
		bob_amount_pos = 0.03
		bob_amount_rot = 1.0
	else:
		# Leve (parado — respiração)
		bob_speed = 3.0
		bob_amount_pos = 0.01
		bob_amount_rot = 0.4

	bob_time += delta * bob_speed

	var bob_y = sin(bob_time) * bob_amount_pos          # sobe/desce
	var bob_x = sin(bob_time * 0.5) * bob_amount_pos*0.5 # pequeno balanço lateral

	camera.position = base_cam_pos + Vector3(bob_x, bob_y, 0)

	# Rotação no eixo X (cabeça inclinando para frente/trás)
	camera.rotation_degrees.x = sin(bob_time) * bob_amount_rot

	if player.is_running:
		camera.fov = lerp(camera.fov, 80.0, 0.15)
	elif is_moving:
		camera.fov = lerp(camera.fov, 72.0, 0.15)
	else:
		camera.fov = lerp(camera.fov, 70.0, 0.1)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var parent_body : Player = get_parent()

		# =============================
		#      MODO SENTADO
		# =============================
		if parent_body.sitting_on_node:
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
				MIN_YAW, MAX_YAW)

		# =============================
		#      MODO NORMAL (em pé)
		# =============================
		else:
			# corpo gira esquerda/direita
			parent_body.rotate_y(deg_to_rad(-event.relative.x * sensitivity))

			# câmera gira pra cima/baixo
			rotation.x = clamp(rotation.x - deg_to_rad(event.relative.y * sensitivity),
				MIN_YAW, MAX_YAW)
