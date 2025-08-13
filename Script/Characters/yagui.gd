extends BasicCharacter
class_name Yagui
func _ready() -> void:
	super._ready()
	animationPlayer = $Yagui1/AnimationPlayer
	actualizarSpeed(1)
	velocity_z = 400
func _physics_process(delta: float) -> void:
	if !is_movie:
		currentState = STATES.RUN
	
	animationController(delta)
	move_and_slide()
func actualizarSpeed(speed:float):
	animationPlayer.speed_scale = speed * (velocity_z * .005)
