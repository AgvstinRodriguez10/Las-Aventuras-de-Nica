extends BasicCharacter
class_name Player
#@onready var animation_nica: AnimationPlayer = $"Nica-v1_0/AnimationPlayer"
@onready var camera_focus: Marker3D = $"../CameraFocus"

const LANES: Array = [-1, 0, 1]  # Lane positions on x-axis
const dist_beetween_lanes = 2
var lateral_free_position := Vector3.ZERO

# Calculamos posición deseada para la cámara
var camera_height = 1.0
var camera_distance = 1.0

# Va de 0 a 2 para enumerar las lineas
var target_lane: int = 1
var velocity_y
var baseVelocity

# Velocidad con la que cambia de carriles
const velociti_change_line:float = 0.5

var is_hitt : bool = false
# Variable que se usa para la animacion del up de vide
var life_plus : bool = false
var life = 3
var snficha = 0

# Timer para la duracion de los powerups
var durationPowerUp:float = 0.0

enum POWERUPSTATE {
	NOTHING,
	SPEEDUP,
	ABOSRBCOIN
}
var currentPowerUp: POWERUPSTATE = POWERUPSTATE.NOTHING

var powerUpDuration:Dictionary = {
	"SPEEDUP" : 4,
	"ABOSRBCOIN": 2
}

var frontalCamIsActive = false
var frontalCamDuration = 7

func _ready() -> void:
	super._ready()
	animationPlayer = $"Nica-v1_0/AnimationPlayer"
	baseVelocity = velocity_z

func _physics_process(delta: float) -> void:
	if currentState == STATES.RUN:
		if Input.is_action_just_pressed("Derecha"):
			if !frontalCamIsActive and target_lane > 0:
				target_lane -= 1 # minimo 0
				changeLine(0.5)
			elif frontalCamIsActive and target_lane < LANES.size() - 1:
				target_lane += 1 # maximo 2
				changeLine(-0.5)
		if Input.is_action_just_pressed("Izquierda"):
			if !frontalCamIsActive and target_lane < LANES.size() - 1 :
				target_lane += 1 # maximo 2
				changeLine(-0.5)
			elif frontalCamIsActive and target_lane > 0:
				target_lane -= 1 # maximo 0
				changeLine(0.5)
				
			# ///LOGICA DE SALTO/// #
		if Input.is_action_pressed("Saltar"):
			currentState = STATES.JUMP
		if Input.is_key_label_pressed(KEY_M):
			#esto deberia cambiar una vez tengamos cuando se activa, llamando directamente a la funcion siguiente
			changeVisionCam()
	
	if currentPowerUp != POWERUPSTATE.NOTHING:
		if durationPowerUp > 0:
			durationPowerUp -= delta
		else:
			# finaliza el power up
			durationPowerUp = 0
			currentPowerUp = POWERUPSTATE.NOTHING
			powerUpActive()

	camera_follow(delta)
	animationController(delta)
	move_and_slide()

func animationController(delta:float):
	super.animationController(delta)
	match currentState:
		STATES.JUMP:
			animationPlayer.play("anim_jump")
			velocity.y = JUMP_VELOCITY
			if velocity.y > 0:
				currentState = STATES.FALL
		STATES.FALL:
			gravityApply(delta)
			if is_on_floor():
				currentState = STATES.RUN
		STATES.HIT:
			animationPlayer.play("anim_hitt")
			gravityApply(delta)

func changeVisionCam():
	#a probar cuando la camara gire en la plaza
	#actualmente esto se esta ejecutando con una tecla, revisar
	var degs = 0
	if !frontalCamIsActive:
		frontalCamIsActive = true
		camera_distance = 4.0
		while(degs > -180):
			degs -= 20
			camera_focus.rotation.y = deg_to_rad(degs)
			await get_tree().create_timer(0).timeout
		
		await get_tree().create_timer(frontalCamDuration).timeout
		
		while(degs < 0):
			degs += 20
			camera_focus.rotation.y = deg_to_rad(degs)
			await get_tree().create_timer(0).timeout
			
		camera_distance = 1.0
		frontalCamIsActive = false
	
func changeLine(dire) -> void:
	var dist_recorrida = 0
	# Esta funcion "interpola" entre un punto y otro con el await para hacer una pasada en cada frame
	while dist_recorrida < dist_beetween_lanes:
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

func setPower(power:POWERUPSTATE):
	currentPowerUp = power
	powerUpActive()

func powerUpActive():
	match currentPowerUp:
		POWERUPSTATE.NOTHING:
			#reinicia todos los valores
			velocity_z = baseVelocity
		POWERUPSTATE.SPEEDUP:
			velocity_z = velocity_z * 2
			durationPowerUp = powerUpDuration.SPEEDUP
		POWERUPSTATE.ABOSRBCOIN:
			durationPowerUp = powerUpDuration.ABOSRBCOIN

func is_hitt_change():
	if is_hitt:
		is_hitt = false
	if velocity.y < 0:
		currentState = STATES.FALL
	else:
		currentState = STATES.RUN

func lostLife():
	is_hitt = true
	currentState = STATES.HIT
	life -= 1

func collectSnFicha():
	snficha += 1
	if (snficha == 3):
		life += 1
		life_plus = true
		snficha = 0
		
