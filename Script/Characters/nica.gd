extends CharacterBody3D
class_name Player
@onready var animation_nica: AnimationPlayer = $"Nica-v1_0/AnimationPlayer"
@onready var camera_focus: Marker3D = $"../CameraFocus"

@onready var soundRun = $SoundRUN

const JUMP_VELOCITY: float = 10.0  # Jump strength
const GRAVITY: float = 24.0  # Gravity strength
const LANES: Array = [-1, 0, 1]  # Lane positions on x-axis
var starting_point: float

var lateral_free_position := Vector3.ZERO

#va de 0 a 2 para enumerar las lineas
var target_lane: int = 1
var velocity_z = 300
var velocity_y
const velociti_change_line:float = 0.5
var eje_local_x:Vector3

var is_movie : bool = false
var is_hitt : bool = false
var life_plus : bool = false
var life = 3

func _ready() -> void:
	position = position
	eje_local_x = global_transform.basis.x.normalized()
	starting_point = 0

func _physics_process(delta: float) -> void:
	if is_movie == false:
		# Almacena la direccion local de donde mira el modelo
		var forward_direction = -global_transform.basis.z.normalized()
		# Aplica velocidad hacia el frente, independientemente de donde mire
		var move_vector = forward_direction * velocity_z * delta
		if is_on_floor():
			if Input.is_action_just_pressed("Derecha") and target_lane > 0:
				target_lane -= 1 # minimo 0
				changeLine(0.5)
			if Input.is_action_just_pressed("Izquierda") and target_lane < LANES.size() - 1:
				target_lane += 1 # maximo 2
				changeLine(-0.5)
			velocity = move_vector

		camera_follow(delta)

	else:
		velocity = Vector3.ZERO

	# ///GRAVEDAD/// #
	if not is_on_floor() and is_movie == false:
		velocity.y -= GRAVITY * delta
	else:
		velocity.y = 0
	# ///LOGICA DE SALTO/// #
	if is_on_floor() and Input.is_action_pressed("Saltar") and is_movie == false:
		velocity.y = JUMP_VELOCITY
	move_and_slide()
	# /// ANIMACIONES /// #
	if is_hitt == false:
		if is_on_floor() and is_movie == false:
			animation_nica.play("anim_run")
			if not soundRun.playing:
				soundRun.play()
		elif not is_on_floor() and is_movie == false:
			animation_nica.play("anim_jump")
			soundRun.stop()
		elif is_movie == true:
			animation_nica.play("anim_idle")
	else :
		animation_nica.play("anim_hitt")
func changeLine(dire):
	var dist_recorrida = 0
	# Esta funcion "interpola" entre un punto y otro con el await para hacer una pasada en cada frame
	while dist_recorrida < 2:
		position += eje_local_x * (velociti_change_line) * dire
		dist_recorrida += velociti_change_line
		await get_tree().process_frame

func camera_follow(delta:float):
	# Obtenemos el eje local del personaje
	var forward_dir = global_transform.basis.z.normalized()
	var up_dir = global_transform.basis.y.normalized()
	var right_dir = global_transform.basis.x.normalized()

	# Actualizamos la posición sin el componente lateral (usamos proyección)
	# Le quitamos el componente de X (right_dir)
	var world_pos = position
	var lateral_component = right_dir * (world_pos - lateral_free_position).dot(right_dir)
	lateral_free_position = world_pos - lateral_component
	
	# Calculamos posición deseada para la cámara
	var camera_distance = 1.0
	var camera_height = 1.0

	# La cámara mira al personaje
	camera_focus.rotation = -camera_focus.rotation.lerp(rotation, 0 * delta)

	# Calculamos la posición destino del camera_focus
	var target_position = lateral_free_position - forward_dir * camera_distance + up_dir * camera_height

	# Limitar el seguimiento en Y para que no suba cuando el personaje salta
	var current_cam_pos = camera_focus.position

	# Si el personaje está en el aire y subiendo, no actualizar Y
	if not is_on_floor() and velocity.y > 0:
		target_position.y = current_cam_pos.y
	# Pero si está bajando (por caída o escalera), permitir que la cámara lo siga
	elif not is_on_floor() and velocity.y < 0:
		# Suavizamos el descenso
		var vertical_gap = current_cam_pos.y - target_position.y
		var descent_speed = clamp(vertical_gap * 3.0, 1.0, 10.0)
		target_position.y = lerp(current_cam_pos.y, target_position.y, delta * descent_speed)
	# Si está en el suelo, seguirlo normalmente
	elif is_on_floor():
		target_position.y = lerp(current_cam_pos.y, target_position.y, delta * 30)

	# Interpolar toda la posición suavemente
	camera_focus.position = camera_focus.position.lerp(target_position, 5 * delta)

func reset_target_line():
	target_lane = 1

func is_movie_change():
	is_movie = !is_movie

func is_hitt_change():
	is_hitt = !is_hitt

func actualizar_eje_local():
	eje_local_x = global_transform.basis.x.normalized()
