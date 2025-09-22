extends Node3D


func _ready() -> void:
	randomizadorDeEscala()


func randomizadorDeEscala():
	var arboles:Array = get_children()
	for arbol:Node3D in arboles:
		arbol.scale.z = randf_range(0.10, 0.13)
