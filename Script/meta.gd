extends Area3D


func _on_body_entered(body: Player) -> void:
	if body.name == "Nica":
		#get_tree().change_scene_to_file("res://Scenes/GUI/pantalla_de_carga.tscn")
		body.velocity_z = 0
		body.currentState = body.STATES.IDLE
		body.is_movie_idle = true
		get_tree().paused = true
		$"../Ganaste!".finished()
	
