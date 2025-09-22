extends Area3D

var animDialogo:AnimationPlayer

func _ready() -> void:
	animDialogo = $Dialogos/AnimationPlayer

func _on_body_entered(body: Node3D) -> void:
	#get_tree().paused = true
	animDialogo.play("DialogoOn")
	#await get_tree().create_timer(1).timeout
	#get_tree().paused = false
