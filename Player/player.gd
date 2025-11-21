extends CharacterBody3D

class_name Player

@onready var head = $head
@onready var camera = $head/Camera3D
@export var interact_ray : RayCast3D

const SPEED = 4.0
const RUN_MULTIPLIER = 2.0
var is_sitting: bool = false
var sitting_on_node: Node3D = null
var sitting_base_yaw: float = 0.0 

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if is_sitting:
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
	
	check_interaction()

func _process(_delta):
	if not is_sitting and Input.is_action_pressed("shift"):
		camera.position = lerp(camera.position, Vector3(0, -0.1, -0.2), 0.1)
		camera.rotation_degrees.x = lerp(camera.rotation_degrees.x, -5.0, 0.1)
		camera.fov = lerp(camera.fov, 80.0, 0.1)
	else:
		camera.position = lerp(camera.position, Vector3.ZERO, 0.1)
		camera.rotation_degrees.x = lerp(camera.rotation_degrees.x, 0.0, 0.1)
		camera.fov = lerp(camera.fov, 70.0, 0.1)

func check_interaction():

	if interact_ray.is_colliding():
		print("Interect Ray está colidindo e", is_sitting)
		var obj = interact_ray.get_collider()
		if obj and obj.is_in_group("interativo"):
			print("É do grupo interativo e", is_sitting)
			obj.mostrar_hint()
			
			if Input.is_action_just_pressed("mouse_esq"):
				if is_sitting and sitting_on_node == obj:
					stand_up()
				elif obj.has_node("SitPoint"):
					sit_down(obj)
				elif obj.has_method("interagir"):
					print("Interagiu com:", obj.name)
					obj.interagir()
				else:
					print("Objeto interativo ", obj.name, " não tem 'SitPoint' nem função 'interagir'.")
		else:
			limpar_hints()
	else:
		limpar_hints()
	
	if is_sitting and Input.is_action_just_pressed("forward"):
		stand_up()

func limpar_hints():
	for inter in get_tree().get_nodes_in_group("interativo"):
		if inter.has_method("esconder_hint"):
			inter.esconder_hint()

func sit_down(chair_node: Node3D):
	if is_sitting: return
	
	var sit_marker = chair_node.get_node("SitPoint")
	
	if not sit_marker:
		print("Erro: Objeto de interação não possui SitPoint.")
		return
		
	is_sitting = true
	sitting_on_node = chair_node
	
	global_transform = sit_marker.global_transform
	
	head.rotation = Vector3.ZERO
	sitting_base_yaw = rotation.y 
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	
	
	var gm = get_tree().get_first_node_in_group("game_manager")
	if gm:
		gm.start_session()

func stand_up():
	if not is_sitting: return
	
	is_sitting = false
	sitting_on_node = null
	
	collision_mask = 1 
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	global_position += Vector3(0, 0.5, 0)
