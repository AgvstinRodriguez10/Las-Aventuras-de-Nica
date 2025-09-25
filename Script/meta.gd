extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if body.name == "Nica":
		get_tree().change_scene_to_file("res://Scenes/GUI/pantalla_de_carga.tscn")
	
