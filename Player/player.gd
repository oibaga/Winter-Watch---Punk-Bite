extends CharacterBody3D

class_name Player

@onready var head = $head
@onready var camera = $head/Camera3D
@export var interact_ray : RayCast3D

const SPEED = 4.0
const RUN_MULTIPLIER = 2.0
var sitting_on_node : Cadeira = null
var sitting_base_yaw: float = 0.0

var atual_objeto : ObjetoInteragivel = null

var gm : GameManager = null

var is_running : bool = false

var bob_time := 0.0
var base_cam_pos := Vector3(0,0,0)


func _ready():
	gm = get_tree().get_first_node_in_group("game_manager")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	check_interaction()
	
	if not sitting_on_node:
		if not is_on_floor():
			velocity.y += get_gravity().y * delta

		var input_dir := Input.get_vector("left", "right", "forward", "backward")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

		var current_speed = SPEED
		if Input.is_action_pressed("shift") and input_dir.y < 0 and input_dir.x == 0:
			if not sitting_on_node:
				is_running = true
				current_speed *= RUN_MULTIPLIER
		else: is_running = false

		if direction:
			velocity.x = direction.x * current_speed
			velocity.z = direction.z * current_speed
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
	else:
		velocity = Vector3.ZERO
		if sitting_on_node: global_position = sitting_on_node.SitPoint.global_position

	move_and_slide()

func _process(delta):
	var horizontal_speed = Vector2(velocity.x, velocity.z).length()
	var is_moving = horizontal_speed > 0.1

	var bob_speed : float
	var bob_amount_pos : float   # amplitude do movimento da posição
	var bob_amount_rot : float   # amplitude da rotação X

	if is_running:
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

	if is_running:
		camera.fov = lerp(camera.fov, 80.0, 0.15)
	elif is_moving:
		camera.fov = lerp(camera.fov, 72.0, 0.15)
	else:
		camera.fov = lerp(camera.fov, 70.0, 0.1)

func check_interaction():
	if interact_ray.is_colliding():
		var obj := AtualizaObjetoAtual()

		if !obj:
			limpar_hints()
			return

		obj.mostrar_hint(self)

		if Input.is_action_just_pressed("mouse_esq"):
			if obj is Cadeira and !sitting_on_node:
				sit_down(obj)
			else:
				obj.interagir()
	else:
		limpar_hints()

func limpar_hints():
	if atual_objeto: 
		atual_objeto.esconder_hint()
		atual_objeto = null

func sit_down(chair_node : Cadeira):
	if sitting_on_node: return

	chair_node.disable_collision()

	sitting_on_node = chair_node
	
	global_position = chair_node.SitPoint.global_position
	rotation = chair_node.SitPoint.rotation
	
	head.rotation = Vector3.ZERO
	sitting_base_yaw = rotation.y 
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if gm: gm.start_session()

func AtualizaObjetoAtual() -> ObjetoInteragivel:
	var obj = interact_ray.get_collider() as ObjetoInteragivel
	
	if obj:
		if not obj.pode_interagir(self): obj = null
	
		if obj != atual_objeto:
			atual_objeto = obj
	
	return obj
