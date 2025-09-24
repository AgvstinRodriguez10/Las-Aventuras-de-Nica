extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if body.name == "Nica":
		body.velocity_z = 0
		body.is_movie = true
		body.currentState = body.STATES.IDLE
