extends Area3D

@onready var Player : CharacterBody3D = $"../../Nica"
@onready var HUD : CanvasLayer = $"../../HUD"

func _on_body_entered(body: Player) -> void:
	if body.name == "Nica" and body.is_hitt == false:
		body.lostLife()
