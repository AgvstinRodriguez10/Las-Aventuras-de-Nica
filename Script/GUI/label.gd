extends CanvasLayer

@onready var timer = $Timer
@onready var animationPlayer = $AnimationPlayer

var x = false

func _ready() -> void:
	if x == false:
		x = true
		get_tree().paused = true
		animationPlayer.play("label")
		timer.start()

func _on_timer_timeout() -> void:
	get_tree().paused = false
	hide()
	x = false
	
