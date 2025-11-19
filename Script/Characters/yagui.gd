extends BasicCharacter
class_name Yagui

var player:Player
var velBasic := 400
var distToPlayer

func _ready() -> void:
	super._ready()
	player = get_tree().get_first_node_in_group("Player")
	animationPlayer = $Yagui1/AnimationPlayer
	actualizarSpeed(1)
	velocity_z = velBasic
	
func _physics_process(delta: float) -> void:
	if !is_movie:
		currentState = STATES.RUN
	
	# Aumenta la velocidad si la distancia de yagui hacia nica es muy amplia para que siempre este posible a alcanzarte
	distToPlayer = position.distance_to(player.position)
	if distToPlayer > 25:
		velocity_z = velBasic * 5
	elif distToPlayer >  15:
		velocity_z = velBasic * 2
	else:
		velocity_z = velBasic
	
	animationController(delta)
	move_and_slide()
	
func actualizarSpeed(speed:float):
	animationPlayer.speed_scale = speed * (velocity_z * .005)

func _on_daño_body_entered(body: Node3D) -> void:
	if body.name == "Nica":
		body.lostLife(3)

func _on_giro_body_entered(body: Node3D) -> void:
	queue_free()
	pass # Replace with function body.
