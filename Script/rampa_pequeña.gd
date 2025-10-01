extends StaticBody3D

@onready var RayLeft =  $"../../Nica/RayLeft"
@onready var RayRigth = $"../../Nica/RayRigth"

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "RayLeft":
		
