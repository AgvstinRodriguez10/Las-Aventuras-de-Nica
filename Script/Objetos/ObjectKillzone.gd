extends Area3D

@onready var Player : CharacterBody3D = $"../../Nica"
@onready var HUD : CanvasLayer = $"../../HUD"

func _on_body_entered(body: Player) -> void:
	if body.name == "Nica" and body.is_hitt == false:
		body.lostLife()


func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	pass # Replace with function body.


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	pass # Replace with function body.
