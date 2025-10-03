extends PathFollow3D

var colliderL = false
var colliderR = false

@onready var rayCastFloor = $Nica/RayCastFloor
@onready var rayCastLeft = $Nica/RayCastLeft
@onready var rayCastRigth = $Nica/RayCastRigth

func _physics_process(delta: float) -> void:
	progress += 0.08
	
	rayCastFloor.force_raycast_update()
	
	print(colliderL)
	
	if $Nica/RayCastLeft.is_colliding():
		colliderL = true
		$Nica/TimerRayLeft.start()
	else:
		colliderL = false
		
	if $Nica/RayCastRigth.is_colliding():
		colliderR = true
		$Nica/TimerRayRigth.start()
	else:
		colliderR = false
	
	if Input.is_action_just_pressed("Izquierda") and colliderL == false:
		$Nica.position.x -= 1
	elif Input.is_action_just_pressed("Derecha") and colliderR == false:
		$Nica.position.x += 1
	
	if rayCastFloor.is_colliding():
		$Nica.position.y = 1
	else:
		$Nica.position.y = 0
	


func _on_timer_ray_left_timeout() -> void:
	colliderL = false


func _on_timer_ray_rigth_timeout() -> void:
	colliderR = false
