extends Area3D
class_name CoinBase

@onready var userInterface:UI = $"../../HUD"
@onready var collision:CollisionShape3D = $CollisionShape3D

var distUp = 3
var posInitial: Vector3
var idleDistUp = 1.1
var targetHeight 

var target:Player

enum STATE {
	IDLE_DOWN,
	IDLE_UP,
	PULLING_UP,
	PULL_IN,
}

var currentState := STATE.IDLE_UP

func _ready() -> void:
	show()
	posInitial = position
	targetHeight = posInitial.y + idleDistUp

func _physics_process(delta: float) -> void:
	match currentState:
		STATE.IDLE_UP:
			animationCoinsUp(delta)
			animRotator(delta)
		STATE.IDLE_DOWN:
			animationCoinsDown(delta)
			animRotator(delta)
		STATE.PULLING_UP:
			if distUp - 0.5 > posInitial.distance_to(position):
				position = position.lerp(posInitial + Vector3(0,1,1) * distUp, 2 * delta)
			else:
				currentState = STATE.PULL_IN
		STATE.PULL_IN:
			if (position.distance_to(target.position) > 2):
				position = position.lerp(target.position, 7 * delta)
			else:
				byebye()

func animationCoinsUp(delta:float):
	#definido en el ready:
	#targetHeight = posInitial.y + idleDistUp
	if(position.y < targetHeight - 0.1):
		position.y = lerpf(position.y, targetHeight, delta * 2.2)
	else:
		currentState = STATE.IDLE_DOWN

func animationCoinsDown(delta:float):
	if(position.y > posInitial.y + 0.05):
		position.y = lerpf(position.y, posInitial.y, delta * 2)
	else:
		currentState = STATE.IDLE_UP

func animRotator(delta:float):
	rotate_y(lerp(0, 2, delta * 2))
	
func _on_body_entered(body: Player) -> void:
	if body.name == "Nica" and (currentState == STATE.IDLE_UP or currentState == STATE.IDLE_DOWN):
		target = body
		currentState = STATE.PULLING_UP

func byebye():
	queue_free()
