extends Node3D

@onready var Player : CharacterBody3D = $"../../Nica"
@onready var HUD : CanvasLayer = $"../../HUD"

func _on_body_entered(body: Player) -> void:
	bodyCollision(body)

func _on_killzone_body_entered(body: Node3D) -> void:
	bodyCollision(body)

func bodyCollision(body):
	if body.name == "Nica" and body.is_hitt == false:
		body.lostLife()
		var collisions: Array

		for elem in get_children():
			if elem.name == "Killzone":
				elem.get_child(0).disabled = true
			elif is_instance_of(elem, CollisionShape3D):
				#collisions.append(elem)
				elem.disabled = true
		#print(collisions)
		#for coll:CollisionShape3D in collisions:
			#coll.disabled = true
