extends CharacterBody3D

@onready var camera = $head/Camera3D
@onready var interact_ray = $head/Camera3D/interact_ray

const SPEED = 4.0
const BOB_FREQ = 2.0
const BOB_AMP = 0.1
var t_bob = 0.0

#script movimentação
func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	check_interaction()

func _process(delta):
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.position = headbob(t_bob)

func headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.y = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos

#script de interação
func check_interaction():
	if interact_ray.is_colliding():
		var obj = interact_ray.get_collider()
		if obj and obj.is_in_group("interativo"):
			obj.mostrar_hint()
			if Input.is_action_just_pressed("mouse_esq"):
				print("Interagiu com:", obj.name)
				obj.interagir()
		else:
			limpar_hints()
	else:
		limpar_hints()

func limpar_hints():
	for inter in get_tree().get_nodes_in_group("interativo"):
		if inter.has_method("esconder_hint"):
			inter.esconder_hint()
