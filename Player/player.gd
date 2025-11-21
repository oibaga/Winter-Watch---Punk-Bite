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

func _ready():
	gm = get_tree().get_first_node_in_group("game_manager")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	check_interaction()
	
	if sitting_on_node:
		velocity = Vector3.ZERO
		if sitting_on_node:
			var sit_marker = sitting_on_node.get_node("SitPoint")
			if sit_marker:
				global_transform = sit_marker.global_transform
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	var current_speed = SPEED
	if Input.is_action_pressed("shift"):
		current_speed *= RUN_MULTIPLIER

	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _process(_delta):
	if not sitting_on_node and Input.is_action_pressed("shift"):
		camera.position = lerp(camera.position, Vector3(0, -0.1, -0.2), 0.1)
		camera.rotation_degrees.x = lerp(camera.rotation_degrees.x, -5.0, 0.1)
		camera.fov = lerp(camera.fov, 80.0, 0.1)
	else:
		camera.position = lerp(camera.position, Vector3.ZERO, 0.1)
		camera.rotation_degrees.x = lerp(camera.rotation_degrees.x, 0.0, 0.1)
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
