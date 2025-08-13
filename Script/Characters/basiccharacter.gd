extends CharacterBody3D
class_name BasicCharacter

var animationPlayer: AnimationPlayer
var is_movie : bool = false
var velocity_z = 300
const JUMP_VELOCITY: float = 10.0  # Jump strength

const GRAVITY: float = 24.0  # Gravity strength

enum STATES  {
	IDLE,
	RUN,
	JUMP,
	FALL,
	HIT
}
var eje_local_x:Vector3

var currentState:STATES = STATES.FALL

func _ready() -> void:
	position = position
	eje_local_x = global_transform.basis.x.normalized()
	
func animationController(delta):
	match currentState:
		STATES.IDLE:
			animationPlayer.play("anim_idle")
			stopMove()
			if !is_movie:
				currentState = STATES.RUN
		STATES.RUN:
			animationPlayer.play("anim_run")
			movingToForward(delta)
			if is_movie:
				currentState = STATES.IDLE
			elif !is_on_floor():
				currentState = STATES.JUMP

func movingToForward(delta: float):
	# Almacena la direccion local de donde mira el modelo
	var forward_direction = -global_transform.basis.z.normalized()
	# Aplica velocidad hacia el frente, independientemente de donde mire
	var move_vector = forward_direction * velocity_z * delta
	
	velocity = move_vector

func gravityApply(delta: float):
	# ///GRAVEDAD/// #
	if not is_on_floor() and is_movie == false:
		velocity.y -= GRAVITY * delta
	else:
		velocity.y = 0
	
func stopMove():
	velocity = Vector3.ZERO
	
func is_movie_change():
	is_movie = !is_movie

func actualizar_eje_local():
	eje_local_x = global_transform.basis.x.normalized()
