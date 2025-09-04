extends CanvasLayer


func _on_button_pressed() -> void:
	$AnimationPlayer.play("Enter")

func changeEscene():
	get_tree().change_scene_to_file("res://Scenes/World/MenuInicial.tscn")
