extends Area3D

@onready var Player : CharacterBody3D = $"../../Nica"
@onready var HUD : CanvasLayer = $"../../HUD"
@onready var timer : Timer = $Timer

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Nica" and body.is_hitt == false:
		body.life -= 1
		body.is_hitt = true
		timer.start()
		
func _on_timer_timeout() -> void:
	Player.is_hitt = false
