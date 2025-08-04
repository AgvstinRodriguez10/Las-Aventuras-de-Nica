extends CanvasLayer

@onready var timer = $Timer
@onready var animationPlayer = $AnimationPlayer

func _ready() -> void:
	get_tree().paused = true
	animationPlayer.play("label")
	timer.start()

func _on_timer_timeout() -> void:
	get_tree().paused = false
	hide()
	
