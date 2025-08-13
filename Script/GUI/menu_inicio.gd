extends CanvasLayer

func _ready() -> void:
	show()

func _on_iniciar_pressed() -> void:
	hide()
	get_tree().change_scene_to_file("res://Scenes/World/main.tscn")

func _on_salir_pressed() -> void:
	get_tree().quit()
