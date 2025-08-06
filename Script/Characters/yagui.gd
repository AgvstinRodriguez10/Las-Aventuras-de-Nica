extends BasicCharacter
class_name Yagui

func _ready() -> void:
	super._ready()
	animationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
	if !is_movie:
		currentState = STATES.RUN
	
	animationController(delta)
	move_and_slide()
