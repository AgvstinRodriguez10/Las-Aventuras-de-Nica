extends Area3D

var streetToDelete : Node3D

func _ready() -> void:
	streetToDelete = get_parent()

func _on_body_entered(body: Node3D) -> void:
	if streetToDelete && body.name == "Nica":
		streetToDelete.queue_free()
