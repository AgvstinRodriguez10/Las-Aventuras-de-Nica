extends Area3D

var animDialogo:AnimationPlayer

func _ready() -> void:
	animDialogo = $Dialogos/AnimationPlayer
#	animDialogo.connect("animation_finished", self, Continuar())
	animDialogo.animation_finished.connect(Continuar)

func _on_body_entered(body: Node3D) -> void:
	get_tree().paused = true
	animDialogo.play("DialogoOn")

func Continuar(name):
	get_tree().paused = false
