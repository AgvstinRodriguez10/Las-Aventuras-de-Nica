extends Node3D
class_name GameController

@onready var directional_light_3d: DirectionalLight3D = $"../DirectionalLight3D"
#@onready var camera_3d: Camera3D = $"../CameraFocus/Camera3D"
@onready var animation_player:AnimationPlayer = $"../CameraFocus/Camera3D/AnimationPlayer"

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	time_controller(delta)
	pass

func time_controller(delta:float):
	if directional_light_3d.light_energy > 0:
		#directional_light_3d.light_energy = directional_light_3d.light_energy - delta * 0.03
		directional_light_3d.light_energy = directional_light_3d.light_energy - delta * 0.8
		if directional_light_3d.light_energy < 0.8:
			animation_player.play("do_night")
