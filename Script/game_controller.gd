extends Node3D
class_name GameController

@onready var directional_light_3d: DirectionalLight3D = $"../DirectionalLight3D"
#@onready var camera_3d: Camera3D = $"../CameraFocus/Camera3D"
@onready var animation_player:AnimationPlayer = $"../CameraFocus/Camera3D/AnimationPlayer"
@export var debugDesdePlazaMitre: bool = false
var isNight

func _ready() -> void:
	isNight = false
	if !debugDesdePlazaMitre:
		$"../Nica".position = Vector3(0,0,0.801)
	else:
		$"../Nica".position = Vector3(0, 0, 546.0)

func _physics_process(delta: float) -> void:
	time_controller(delta)

func time_controller(delta:float):
	if directional_light_3d.light_energy > 0:
		#si tiene el debug desdse la plaza, la oscuridad se acelera para ver efectos de noche
		if !debugDesdePlazaMitre:
			directional_light_3d.light_energy = directional_light_3d.light_energy - delta * 0.03
		else:
			directional_light_3d.light_energy = directional_light_3d.light_energy - delta * 0.8
		
		if directional_light_3d.light_energy < 0.1 && !isNight:
			animation_player.play("do_night")
			isNight = true
