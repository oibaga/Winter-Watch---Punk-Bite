extends CharacterBody3D

class_name Player

@onready var head = $head

@export var interact_ray : RayCast3D
@export var animation_player : AnimationPlayer
@export var SPEED = 3.0
@export var RUN_MULTIPLIER = 1.75

var sitting_on_node : Cadeira = null
var sitting_base_yaw: float = 0.0

var atual_objeto : ObjetoInteragivel = null

var gm : GameManager = null

var is_running : bool = false

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
