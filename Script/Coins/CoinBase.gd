extends Area3D
class_name CoinBase

@onready var userInterface:UI = $"../../HUD"
@onready var collision:CollisionShape3D = $CollisionShape3D

var distUp = 4
var posInitial: Vector3

var target:Player

enum STATE {
	IDLE,
	PULLING_UP,
	PULL_IN,
}

var currentState := STATE.IDLE

func _ready() -> void:
	show()
	posInitial = position
	

func _physics_process(delta: float) -> void:
	match currentState:
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

func _on_body_entered(body: CharacterBody3D) -> void:
	if body.name == "Nica" and currentState == STATE.IDLE:
		target = body
		currentState = STATE.PULLING_UP

func byebye():
	queue_free()
